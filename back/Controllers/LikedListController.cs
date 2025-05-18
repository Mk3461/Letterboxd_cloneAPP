using back.models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;

[ApiController]
[Route("api/[controller]")]
public class LikedListController : ControllerBase
{
    private readonly string _connectionString;
    private readonly string _baseUrl = "http://10.0.2.2:5001/images";

    public LikedListController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    [HttpGet("user/{userId}")]
    public IActionResult GetLikedMoviesByUser(int userId)
    {
        var likedMovies = new List<object>();

        using (var connection = new MySqlConnection(_connectionString))
        {
            connection.Open();

            string query = @"
                SELECT f.Id, f.film_adi, f.filmresim 
                FROM likedlist l
                INNER JOIN filmler f ON l.film_id = f.Id
                WHERE l.kullanici_id = @userId";

            using (var command = new MySqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@userId", userId);

                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string imageUrl = null;

                        if (!reader.IsDBNull(reader.GetOrdinal("filmresim")))
                        {
                            var bytes = reader.GetFieldValue<byte[]>(reader.GetOrdinal("filmresim"));

                            using var md5 = MD5.Create();
                            var hashBytes = md5.ComputeHash(bytes);
                            var hash = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
                            var fileName = $"{hash}.jpg";
                            var imagePath = Path.Combine("wwwroot/images", fileName);

                            if (!System.IO.File.Exists(imagePath))
                            {
                                Directory.CreateDirectory("wwwroot/images");
                                System.IO.File.WriteAllBytes(imagePath, bytes);
                            }

                            imageUrl = $"{_baseUrl}/{fileName}";
                        }

                        likedMovies.Add(new
                        {
                            Id = reader.GetInt32("Id"),
                            film_adi = reader.GetString("film_adi"),
                            filmResim = imageUrl
                        });
                    }
                }
            }
        }

        return Ok(likedMovies);
    }
    [HttpPost("ekle")]
    public IActionResult AddToLikedList([FromBody] LikedList model)
    {
        using (var connection = new MySqlConnection(_connectionString))
        {
            connection.Open();

            string checkQuery = "SELECT COUNT(*) FROM likedlist WHERE kullanici_id = @userId AND film_id = @filmId";
            using (var checkCommand = new MySqlCommand(checkQuery, connection))
            {
                checkCommand.Parameters.AddWithValue("@userId", model.KullaniciId);
                checkCommand.Parameters.AddWithValue("@filmId", model.FilmId);

                long count = (long)checkCommand.ExecuteScalar();
                if (count > 0)
                {
                    return BadRequest("Bu film zaten beğenilmiş.");
                }
            }

            string insertQuery = "INSERT INTO likedlist (kullanici_id, film_id) VALUES (@userId, @filmId)";
            using (var insertCommand = new MySqlCommand(insertQuery, connection))
            {
                insertCommand.Parameters.AddWithValue("@userId", model.KullaniciId);
                insertCommand.Parameters.AddWithValue("@filmId", model.FilmId);
                insertCommand.ExecuteNonQuery();
            }
        }

        return Ok("Film başarıyla beğenildi.");
    }
    [HttpGet("listele")]
    public IActionResult Listele(int kullaniciId)
    {
        var films = new List<Film>();
        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand(@"
        SELECT f.id, f.film_adi, f.ozet, f.vizyon_yili, f.imdb_puani, f.filmresim, y.ad_soyad
        FROM likedlist l
        JOIN filmler f ON l.film_id = f.id
        LEFT JOIN yonetmenler y ON f.yonetmen_id = y.id
        WHERE l.kullanici_id = @kid", conn);
        cmd.Parameters.AddWithValue("@kid", kullaniciId);

        using var reader = cmd.ExecuteReader();
        while (reader.Read())
        {
            string imageUrl = null;

            if (!reader.IsDBNull(reader.GetOrdinal("filmresim")))
            {
                var bytes = reader.GetFieldValue<byte[]>(reader.GetOrdinal("filmresim"));

                using var md5 = MD5.Create();
                var hashBytes = md5.ComputeHash(bytes);
                var hash = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
                var fileName = $"{hash}.jpg";
                var imagePath = Path.Combine("wwwroot/images", fileName);

                if (!System.IO.File.Exists(imagePath))
                {
                    Directory.CreateDirectory("wwwroot/images");
                    System.IO.File.WriteAllBytes(imagePath, bytes);
                }

                imageUrl = $"{_baseUrl}/{fileName}";
            }

            var film = new Film
            {
                Id = reader.GetInt32("id"),
                FilmAdi = reader.GetString("film_adi"),
                Ozet = reader.GetString("ozet"),
                VizyonYili = reader.GetInt32("vizyon_yili"),
                ImdbPuani = reader.GetDouble("imdb_puani"),
                FilmResim = imageUrl,
                YonetmenAdi = reader.IsDBNull(reader.GetOrdinal("ad_soyad")) ? null : reader.GetString("ad_soyad"),
                Oyuncular = new List<string>(),
                Turler = new List<string>()
            };
            films.Add(film);
        }

        foreach (var film in films)
        {
            film.Oyuncular = GetOyuncular(film.Id);
            film.Turler = GetTurler(film.Id);
        }

        return Ok(films);
    }
    private List<string> GetOyuncular(int filmId)
    {
        var oyuncular = new List<string>();
        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand(@"
        SELECT o.ad_soyad FROM filmoyuncular fo
        JOIN oyuncular o ON fo.oyuncu_id = o.id
        WHERE fo.film_id = @fid", conn);
        cmd.Parameters.AddWithValue("@fid", filmId);

        using var reader = cmd.ExecuteReader();
        while (reader.Read())
        {
            oyuncular.Add(reader.GetString("ad_soyad"));
        }

        return oyuncular;
    }

    private List<string> GetTurler(int filmId)
    {
        var turler = new List<string>();
        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand(@"
        SELECT t.tur_adi FROM filmturleri ft
        JOIN turler t ON ft.tur_id = t.id
        WHERE ft.film_id = @fid", conn);
        cmd.Parameters.AddWithValue("@fid", filmId);

        using var reader = cmd.ExecuteReader();
        while (reader.Read())
        {
            turler.Add(reader.GetString("tur_adi"));
        }

        return turler;
    }



}

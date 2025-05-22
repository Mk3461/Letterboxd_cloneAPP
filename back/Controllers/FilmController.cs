using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System.IO;
using System;
using System.Security.Cryptography;
using System;
using back.models;

[ApiController]
[Route("api/[controller]")]
public class FilmController : ControllerBase
{
    private readonly string _connectionString;
    private readonly string _baseUrl = "http://10.0.2.2:5001/images";

    public FilmController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    // Tüm filmleri getiren endpoint
    [HttpGet]
    [HttpGet]
    [Route("all")]
    public IActionResult GetAllFilms()
    {
        var filmler = new List<Film>();

        using (var connection = new MySqlConnection(_connectionString))
        {
            connection.Open();

            var command = new MySqlCommand(@"
            SELECT f.id, f.film_adi, f.ozet, f.vizyon_yili, f.imdb_puani, f.filmresim, f.video,
                   y.ad_soyad AS yonetmen_adi
            FROM filmler f
            LEFT JOIN yonetmenler y ON f.yonetmen_id = y.id", connection);

            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                string imageUrl = null;
                string videoUrl = null;

                // Film resmi dosyasını yaz
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

                // Video blob varsa video dosyasını yaz
                if (!reader.IsDBNull(reader.GetOrdinal("video")))
                {
                    var videoBytes = reader.GetFieldValue<byte[]>(reader.GetOrdinal("video"));

                    using var md5 = MD5.Create();
                    var hashBytes = md5.ComputeHash(videoBytes);
                    var hash = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
                    var videoFileName = $"{hash}.mp4"; // video formatın .mov ise
                    var videoPath = Path.Combine("wwwroot/videos", videoFileName);

                    if (!System.IO.File.Exists(videoPath))
                    {
                        Directory.CreateDirectory("wwwroot/videos");
                        System.IO.File.WriteAllBytes(videoPath, videoBytes);
                    }

                    videoUrl = $"http://10.0.2.2:5001/videos/{videoFileName}";
                }

                var film = new Film
                {
                    Id = reader.GetInt32("id"),
                    FilmAdi = reader.GetString("film_adi"),
                    Ozet = reader.GetString("ozet"),
                    VizyonYili = reader.GetInt32("vizyon_yili"),
                    ImdbPuani = reader.GetDouble("imdb_puani"),
                    FilmResim = imageUrl,
                    Video = videoUrl,
                    YonetmenAdi = reader.IsDBNull(reader.GetOrdinal("yonetmen_adi")) ? null : reader.GetString("yonetmen_adi"),
                    Oyuncular = new List<string>(),
                    Turler = new List<string>()
                };
                // Oyuncuları getir
                using (var oConn = new MySqlConnection(_connectionString))
                {
                    oConn.Open();
                    var oyuncuCmd = new MySqlCommand(@"
        SELECT o.ad_soyad 
        FROM filmoyuncular fo
        JOIN oyuncular o ON fo.oyuncu_id = o.id
        WHERE fo.film_id = @filmId", oConn);

                    oyuncuCmd.Parameters.AddWithValue("@filmId", film.Id);
                    using var oReader = oyuncuCmd.ExecuteReader();
                    while (oReader.Read())
                        film.Oyuncular.Add(oReader.GetString("ad_soyad"));
                }

                // Türleri getir
                using (var tConn = new MySqlConnection(_connectionString))
                {
                    tConn.Open();
                    var turCmd = new MySqlCommand(@"
                                            SELECT t.tur_adi
                                            FROM filmturleri ft
                                            JOIN turler t ON ft.tur_id = t.id
                                            WHERE ft.film_id = @filmId", tConn);

                    turCmd.Parameters.AddWithValue("@filmId", film.Id);
                    using var tReader = turCmd.ExecuteReader();
                    while (tReader.Read())
                        film.Turler.Add(tReader.GetString("tur_adi"));
                }


                filmler.Add(film);
            }
        }



        return Ok(filmler);
    }

    [HttpGet]
    [Route("random")]
    public IActionResult GetRandomFilm()
    {
        Film film = null;

        using (var connection = new MySqlConnection(_connectionString))
        {
            connection.Open();

            var command = new MySqlCommand(@"
                SELECT f.id, f.film_adi, f.ozet, f.vizyon_yili, f.imdb_puani, f.filmresim,
                       y.ad_soyad AS yonetmen_adi
                FROM filmler f
                LEFT JOIN yonetmenler y ON f.yonetmen_id = y.id
                ORDER BY RAND()
                LIMIT 1", connection);

            using var reader = command.ExecuteReader();
            if (reader.Read())
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

                film = new Film
                {
                    Id = reader.GetInt32("id"),
                    FilmAdi = reader.GetString("film_adi"),
                    Ozet = reader.GetString("ozet"),
                    VizyonYili = reader.GetInt32("vizyon_yili"),
                    ImdbPuani = reader.GetDouble("imdb_puani"),
                    FilmResim = imageUrl,
                    YonetmenAdi = reader.IsDBNull(reader.GetOrdinal("yonetmen_adi")) ? null : reader.GetString("yonetmen_adi"),
                    Oyuncular = new List<string>(),
                    Turler = new List<string>()
                };
            }
        }

        if (film == null)
            return NotFound("Film bulunamadı");

        // Oyuncular
        using (var oConn = new MySqlConnection(_connectionString))
        {
            oConn.Open();
            var oyuncuCmd = new MySqlCommand(@"
                SELECT o.ad_soyad 
                FROM filmoyuncular fo
                JOIN oyuncular o ON fo.oyuncu_id = o.id
                WHERE fo.film_id = @filmId", oConn);

            oyuncuCmd.Parameters.AddWithValue("@filmId", film.Id);
            using var oReader = oyuncuCmd.ExecuteReader();
            while (oReader.Read())
                film.Oyuncular.Add(oReader.GetString("ad_soyad"));
        }

        // Türler
        using (var tConn = new MySqlConnection(_connectionString))
        {
            tConn.Open();
            var turCmd = new MySqlCommand(@"
                SELECT t.tur_adi
                FROM filmturleri ft
                JOIN turler t ON ft.tur_id = t.id
                WHERE ft.film_id = @filmId", tConn);

            turCmd.Parameters.AddWithValue("@filmId", film.Id);
            using var tReader = turCmd.ExecuteReader();
            while (tReader.Read())
                film.Turler.Add(tReader.GetString("tur_adi"));
        }

        return Ok(film);
    }
    [HttpGet("getWatchlist")]
    public IActionResult GetWatchlist(int kullaniciId)
    {
        var films = new List<object>();

        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var query = @"
        SELECT f.id, f.film_adi, f.filmresim, f.ozet, f.imdb_puani, f.vizyon_yili,
               y.ad_soyad,
               GROUP_CONCAT(DISTINCT t.tur_adi) AS turler,
               GROUP_CONCAT(DISTINCT o.ad_soyad) AS oyuncular
        FROM watchedlist wl
        JOIN filmler f ON wl.film_id = f.id
        LEFT JOIN filmturleri ft ON f.id = ft.film_id
        LEFT JOIN turler t ON ft.tur_id = t.id
        LEFT JOIN filmoyuncular fo ON f.id = fo.film_id
        LEFT JOIN oyuncular o ON fo.oyuncu_id = o.id
        LEFT JOIN yonetmenler y ON f.yonetmen_id = y.id
        WHERE wl.kullanici_id = @kid
        GROUP BY f.id, f.film_adi, f.filmResim, f.ozet, f.imdb_puani, f.vizyon_yili, y.ad_soyad";

        var cmd = new MySqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@kid", kullaniciId);

        using var reader = cmd.ExecuteReader();
        while (reader.Read())
        {
            var film = new
            {
                id = reader.GetInt32("id"),
                filmAdi = reader["film_adi"]?.ToString(),
                filmResim = reader["filmResim"]?.ToString(),
                ozet = reader["ozet"]?.ToString(),
                imdbPuani = reader["imdb_puani"] is DBNull ? 0.0 : Convert.ToDouble(reader["imdb_puani"]),
                vizyonYili = reader["vizyon_yili"] is DBNull ? 0 : Convert.ToInt32(reader["vizyon_yili"]),
                yonetmenAdi = reader["yonetmen_id"]?.ToString(),
                turler = reader["turler"]?.ToString()?.Split(',') ?? Array.Empty<string>(),
                oyuncular = reader["oyuncular"]?.ToString()?.Split(',') ?? Array.Empty<string>()
            };

            films.Add(film);
        }

        return Ok(films);
    }
}

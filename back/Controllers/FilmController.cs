using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System.IO;
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
    [Route("all")]
    public IActionResult GetAllFilms()
    {
        var filmler = new List<Film>();

        using (var connection = new MySqlConnection(_connectionString))
        {
            connection.Open();

            var command = new MySqlCommand(@"
                SELECT f.id, f.film_adi, f.ozet, f.vizyon_yili, f.imdb_puani, f.filmresim,
                       y.ad_soyad AS yonetmen_adi
                FROM filmler f
                LEFT JOIN yonetmenler y ON f.yonetmen_id = y.id", connection);

            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                string imageUrl = null;

                if (!reader.IsDBNull(reader.GetOrdinal("filmresim")))
                {
                    var bytes = reader.GetFieldValue<byte[]>(reader.GetOrdinal("filmresim"));
                    var fileName = $"{Guid.NewGuid()}.jpg";
                    var imagePath = Path.Combine("wwwroot/images", fileName);

                    Directory.CreateDirectory("wwwroot/images");

                    System.IO.File.WriteAllBytes(imagePath, bytes);

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
                    YonetmenAdi = reader.IsDBNull(reader.GetOrdinal("yonetmen_adi")) ? null : reader.GetString("yonetmen_adi"),
                    Oyuncular = new List<string>(),
                    Turler = new List<string>()
                };

                filmler.Add(film);
            }
        }

        if (filmler.Count == 0)
            return NotFound("Filmler bulunamadı");

        // Oyuncular ve Türler
        foreach (var film in filmler)
        {
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
        }

        return Ok(filmler);
    }

    // Rastgele bir film getiren endpoint
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
                    var fileName = $"{Guid.NewGuid()}.jpg";
                    var imagePath = Path.Combine("wwwroot/images", fileName);

                    Directory.CreateDirectory("wwwroot/images");

                    System.IO.File.WriteAllBytes(imagePath, bytes);

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
}

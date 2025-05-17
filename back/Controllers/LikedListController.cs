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
}

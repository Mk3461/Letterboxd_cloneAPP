using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System.IO;

[ApiController]
[Route("api/[controller]")]
public class ListeController : ControllerBase
{
    private string connectionString = "server=localhost;user=root;password=123456789;database=filmler;port=3306;";

    [HttpPost("film-ekle")]
    public IActionResult FilmListeyeEkle([FromBody] Liste model)
    {
        try
        {
            using var conn = new MySqlConnection(connectionString);
            conn.Open();

            // 1. Liste var mı kontrol et
            int listeId = -1;
            var checkListeCmd = new MySqlCommand("SELECT id FROM listeler WHERE ad = @ad AND kullanici_id = @kullanici_id", conn);
            checkListeCmd.Parameters.AddWithValue("@ad", model.ListeAdi);
            checkListeCmd.Parameters.AddWithValue("@kullanici_id", model.KullaniciId);

            using (var reader = checkListeCmd.ExecuteReader())
            {
                if (reader.Read())
                {
                    listeId = reader.GetInt32("id");
                }
            }

            // 2. Yoksa liste oluştur
            if (listeId == -1)
            {
                var insertListeCmd = new MySqlCommand("INSERT INTO listeler (kullanici_id, ad) VALUES (@kullanici_id, @ad)", conn);
                insertListeCmd.Parameters.AddWithValue("@kullanici_id", model.KullaniciId);
                insertListeCmd.Parameters.AddWithValue("@ad", model.ListeAdi);
                insertListeCmd.ExecuteNonQuery();
                listeId = (int)insertListeCmd.LastInsertedId;
            }

            // 3. Film listede var mı kontrol et
            var checkFilmCmd = new MySqlCommand("SELECT liste_id FROM listefilmleri WHERE liste_id = @liste_id AND film_id = @film_id", conn);
            checkFilmCmd.Parameters.AddWithValue("@liste_id", listeId);
            checkFilmCmd.Parameters.AddWithValue("@film_id", model.FilmId);

            using (var filmReader = checkFilmCmd.ExecuteReader())
            {
                if (filmReader.Read())
                {
                    return BadRequest("Bu film zaten listede mevcut.");
                }
            }

            // 4. Listeye filmi ekle
            var insertFilmCmd = new MySqlCommand("INSERT INTO listefilmleri (liste_id, film_id) VALUES (@liste_id, @film_id)", conn);
            insertFilmCmd.Parameters.AddWithValue("@liste_id", listeId);
            insertFilmCmd.Parameters.AddWithValue("@film_id", model.FilmId);
            insertFilmCmd.ExecuteNonQuery();

            return Ok("Film listeye eklendi.");
        }
        catch (MySqlException ex)
        {
            return StatusCode(500, $"MySQL hatası: {ex.Message}");
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Sunucu hatası: {ex.Message}");
        }
    }

    [HttpGet("liste/{kullaniciId}/{listeAdi}")]
    public IActionResult ListeyiGetir(int kullaniciId, string listeAdi)
    {
        try
        {
            var filmler = new List<object>();
            var baseUrl = "http://10.0.2.2:5001/images";  // Burayı kendi sunucuna göre ayarla

            using var conn = new MySqlConnection(connectionString);
            conn.Open();

            // Önce listemizin ID'sini alalım
            int listeId = -1;
            var listeIdCmd = new MySqlCommand("SELECT id FROM listeler WHERE kullanici_id = @kullanici_id AND ad = @ad", conn);
            listeIdCmd.Parameters.AddWithValue("@kullanici_id", kullaniciId);
            listeIdCmd.Parameters.AddWithValue("@ad", listeAdi);

            using (var reader = listeIdCmd.ExecuteReader())
            {
                if (reader.Read())
                    listeId = reader.GetInt32("id");
                else
                    return NotFound("Böyle bir liste bulunamadı.");
            }

            // Listemizdeki filmleri çekelim
            var filmsCmd = new MySqlCommand(@"
                SELECT f.id, f.film_adi, f.ozet, f.vizyon_yili, f.imdb_puani, f.filmresim
                FROM listefilmleri lf
                JOIN filmler f ON lf.film_id = f.id
                WHERE lf.liste_id = @liste_id", conn);
            filmsCmd.Parameters.AddWithValue("@liste_id", listeId);

            using var filmReader = filmsCmd.ExecuteReader();
            while (filmReader.Read())
            {
                string imageUrl = null;

                if (!filmReader.IsDBNull(filmReader.GetOrdinal("filmresim")))
                {
                    var bytes = filmReader.GetFieldValue<byte[]>(filmReader.GetOrdinal("filmresim"));

                    using var md5 = System.Security.Cryptography.MD5.Create();
                    var hashBytes = md5.ComputeHash(bytes);
                    var hash = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
                    var fileName = $"{hash}.jpg";

                    var imagePath = Path.Combine("wwwroot/images", fileName);
                    if (!System.IO.File.Exists(imagePath))
                    {
                        System.IO.Directory.CreateDirectory("wwwroot/images");
                        System.IO.File.WriteAllBytes(imagePath, bytes);
                    }

                    imageUrl = $"{baseUrl}/{fileName}";
                }

                filmler.Add(new
                {
                    Id = filmReader.GetInt32("id"),
                    FilmAdi = filmReader.GetString("film_adi"),
                    Ozet = filmReader.GetString("ozet"),
                    VizyonYili = filmReader.GetInt32("vizyon_yili"),
                    ImdbPuani = filmReader.GetDouble("imdb_puani"),
                    FilmResim = imageUrl
                });
            }

            return Ok(filmler);
        }
        catch (MySqlException ex)
        {
            return StatusCode(500, $"MySQL hatası: {ex.Message}");
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Sunucu hatası: {ex.Message}");
        }
    }
    [HttpGet("kullanici-listeleri/{kullaniciId}")]
    public IActionResult KullaniciListeleriniGetir(int kullaniciId)
    {
        try
        {
            var listeAdlari = new List<string>();
            using var conn = new MySqlConnection(connectionString);
            conn.Open();

            var cmd = new MySqlCommand("SELECT ad FROM listeler WHERE kullanici_id = @kullanici_id", conn);
            cmd.Parameters.AddWithValue("@kullanici_id", kullaniciId);

            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                listeAdlari.Add(reader.GetString("ad"));
            }

            return Ok(listeAdlari);
        }
        catch (MySqlException ex)
        {
            return StatusCode(500, $"MySQL hatası: {ex.Message}");
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Sunucu hatası: {ex.Message}");
        }
    }

}

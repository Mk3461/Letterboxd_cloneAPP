using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Security.Cryptography;
using System.Text;

[ApiController]
[Route("api/[controller]")]
public class KullaniciController : ControllerBase
{
    private readonly string _connectionString;

    public KullaniciController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    private void CreatePasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
    {
        using var hmac = new HMACSHA512();
        passwordSalt = hmac.Key;
        passwordHash = hmac.ComputeHash(Encoding.UTF8.GetBytes(password));
    }

    private bool VerifyPasswordHash(string password, byte[] storedHash, byte[] storedSalt)
    {
        using var hmac = new HMACSHA512(storedSalt);
        var computedHash = hmac.ComputeHash(Encoding.UTF8.GetBytes(password));
        return computedHash.SequenceEqual(storedHash);
    }

    [HttpPost("ekle")]
    public IActionResult Ekle([FromBody] Kullanici kullanici)
    {
        if (string.IsNullOrEmpty(kullanici.Sifre))
            return BadRequest("Şifre zorunludur.");

        try
        {
            CreatePasswordHash(kullanici.Sifre, out byte[] passwordHash, out byte[] passwordSalt);

            using var conn = new MySqlConnection(_connectionString);
            conn.Open();

            var cmd = new MySqlCommand(@"
            INSERT INTO kullanicilar 
            (kullanici_adi, cinsiyet, isim, soyisim, yas, password_hash, password_salt) 
            VALUES 
            (@kullaniciAdi, @cinsiyet, @ad, @soyad, @yas, @passwordHash, @passwordSalt)", conn);

            cmd.Parameters.AddWithValue("@kullaniciAdi", kullanici.KullaniciAdi);
            cmd.Parameters.AddWithValue("@cinsiyet", kullanici.Cinsiyet);
            cmd.Parameters.AddWithValue("@ad", kullanici.isim);
            cmd.Parameters.AddWithValue("@soyad", kullanici.soyisim);
            cmd.Parameters.AddWithValue("@yas", kullanici.Yas);
            cmd.Parameters.AddWithValue("@passwordHash", Convert.ToBase64String(passwordHash));
            cmd.Parameters.AddWithValue("@passwordSalt", Convert.ToBase64String(passwordSalt));

            var result = cmd.ExecuteNonQuery();

            return result > 0 ? Ok("Kullanıcı eklendi") : StatusCode(500, "Kullanıcı eklenirken hata oluştu");
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Hata: {ex.Message}");
        }
    }



    [HttpGet("hepsi")]
    public IActionResult GetAllKullanicilar()
    {
        var kullanicilar = new List<Kullanici>();

        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand("SELECT id, kullanici_adi, cinsiyet, isim, soyisim, yas FROM kullanicilar", conn);

        using var reader = cmd.ExecuteReader();
        while (reader.Read())
        {
            kullanicilar.Add(new Kullanici
            {
                Id = reader.GetInt32("id"),
                KullaniciAdi = reader.GetString("kullanici_adi"),
                Cinsiyet = reader.GetString("cinsiyet"),
                isim = reader.GetString("isim"),
                soyisim = reader.GetString("soyisim"),
                Yas = reader.GetInt32("yas"),
                // Sifre, password_hash veya salt gönderilmez!
            });
        }

        return Ok(kullanicilar);
    }


    [HttpPost("giris")]
    public IActionResult GirisYap([FromBody] KullaniciGirisModel model)
    {
        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand("SELECT id, password_hash, password_salt FROM kullanicilar WHERE kullanici_adi = @kullanici_adi", conn);
        cmd.Parameters.AddWithValue("@kullanici_adi", model.KullaniciAdi);

        using var reader = cmd.ExecuteReader();
        if (reader.Read())
        {
            var userId = reader.GetInt32("id");
            var storedHash = Convert.FromBase64String(reader.GetString("password_hash"));
            var storedSalt = Convert.FromBase64String(reader.GetString("password_salt"));

            using var hmac = new HMACSHA512(storedSalt);
            var computedHash = hmac.ComputeHash(Encoding.UTF8.GetBytes(model.Sifre));

            if (computedHash.SequenceEqual(storedHash))
            {
                return Ok(new
                {
                    success = true,
                    userId = userId
                });
            }
        }

        return Unauthorized(new { success = false });
    }




}

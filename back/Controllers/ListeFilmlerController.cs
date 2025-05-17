using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;

[ApiController]
[Route("api/[controller]")]
public class ListeController : ControllerBase
{
    private readonly string _connectionString;

    public ListeController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    [HttpPost("olustur")]
    public IActionResult ListeOlustur(int kullaniciId, string ad)
    {
        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand("INSERT INTO listeler (kullanici_id, ad) VALUES (@kid, @ad)", conn);
        cmd.Parameters.AddWithValue("@kid", kullaniciId);
        cmd.Parameters.AddWithValue("@ad", ad);

        return cmd.ExecuteNonQuery() > 0 ? Ok("Liste oluşturuldu") : StatusCode(500);
    }

    [HttpPost("film-ekle")]
    public IActionResult FilmeEkle(int listeId, int filmId)
    {
        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand("INSERT INTO listefilmleri (liste_id, film_id) VALUES (@lid, @fid)", conn);
        cmd.Parameters.AddWithValue("@lid", listeId);
        cmd.Parameters.AddWithValue("@fid", filmId);

        return cmd.ExecuteNonQuery() > 0 ? Ok("Film listeye eklendi") : StatusCode(500);
    }

    [HttpGet("filmleri")]
    public IActionResult ListeFilmleri(int listeId)
    {
        var list = new List<int>();
        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand("SELECT film_id FROM listefilmleri WHERE liste_id = @lid", conn);
        cmd.Parameters.AddWithValue("@lid", listeId);

        using var reader = cmd.ExecuteReader();
        while (reader.Read())
            list.Add(reader.GetInt32("film_id"));

        return Ok(list);
    }
}

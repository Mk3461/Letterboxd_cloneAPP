using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;

[ApiController]
[Route("api/[controller]")]
public class WatchListController : ControllerBase
{
    private readonly string _connectionString;

    public WatchListController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    [HttpPost("ekle")]
    public IActionResult Ekle(int kullaniciId, int filmId)
    {
        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand("INSERT INTO watchlist (kullanici_id, film_id) VALUES (@kid, @fid)", conn);
        cmd.Parameters.AddWithValue("@kid", kullaniciId);
        cmd.Parameters.AddWithValue("@fid", filmId);

        return cmd.ExecuteNonQuery() > 0 ? Ok("Film watchlist'e eklendi") : StatusCode(500);
    }

    [HttpDelete("sil")]
    public IActionResult Sil(int kullaniciId, int filmId)
    {
        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand("DELETE FROM watchlist WHERE kullanici_id = @kid AND film_id = @fid", conn);
        cmd.Parameters.AddWithValue("@kid", kullaniciId);
        cmd.Parameters.AddWithValue("@fid", filmId);

        return cmd.ExecuteNonQuery() > 0 ? Ok("Film silindi") : NotFound();
    }

    [HttpGet("listele")]
    public IActionResult Listele(int kullaniciId)
    {
        var list = new List<int>();
        using var conn = new MySqlConnection(_connectionString);
        conn.Open();

        var cmd = new MySqlCommand("SELECT film_id FROM watchlist WHERE kullanici_id = @kid", conn);
        cmd.Parameters.AddWithValue("@kid", kullaniciId);

        using var reader = cmd.ExecuteReader();
        while (reader.Read())
            list.Add(reader.GetInt32("film_id"));

        return Ok(list);
    }
}

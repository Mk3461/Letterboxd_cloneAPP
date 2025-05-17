public class WatchedList
{
    public int Id { get; set; }
    public int KullaniciId { get; set; }
    public int FilmId { get; set; }

    public Kullanici Kullanici { get; set; }
}
public class Liste
{
    public int Id { get; set; }
    public int KullaniciId { get; set; }
    public string Ad { get; set; }

    public Kullanici Kullanici { get; set; }
    public ICollection<ListeFilmleri> ListeFilmleri { get; set; }
}
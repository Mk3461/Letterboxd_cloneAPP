public class Kullanici
{
    public int Id { get; set; }
    public string KullaniciAdi { get; set; }
    public string Cinsiyet { get; set; }
    public string isim { get; set; }
    public string soyisim { get; set; }
    public int Yas { get; set; }

    // Sifre plain text olarak API tarafında gönderiliyor, burada opsiyonel olabilir
    public string? Sifre { get; set; }

    // Şifre hash ve salt olarak saklanıyor
    public string? PasswordHash { get; set; }
    public string? PasswordSalt { get; set; }

    public ICollection<LikedList>? LikedList { get; set; }
    public ICollection<WatchedList>? WatchedList { get; set; }
    public ICollection<WatchList>? WatchList { get; set; }
    public ICollection<Liste>? Listeler { get; set; }
}

public class KullaniciGirisModel
{
    public string KullaniciAdi { get; set; }
    public string Sifre { get; set; }
}


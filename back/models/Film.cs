namespace back.models
{
    public class Film
    {
        public int Id { get; set; }
        public string FilmAdi { get; set; }
        public string Ozet { get; set; }
        public int VizyonYili { get; set; }
        public double ImdbPuani { get; set; }
        public string FilmResim { get; set; }
        public string YonetmenAdi { get; set; }
        public List<string> Oyuncular { get; set; }
        public List<string> Turler { get; set; }
    }
}
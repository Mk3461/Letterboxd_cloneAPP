class Film {
  final int id;
  final String? film_adi;
  final String? filmResim;
  final String? ozet;
  final double imdbPuani;
  final List<String> turler;
  final List<String> oyuncular;
  final String yonetmen;
  final int yil;

  Film({
    required this.id,
    this.film_adi,
    this.filmResim,
    this.ozet,
    required this.imdbPuani,
    required this.turler,
    required this.oyuncular,
    required this.yonetmen,
    required this.yil,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      filmResim: json['filmResim'],
      film_adi: json["filmAdi"],
      ozet: json['ozet'],
      imdbPuani: (json['imdbPuani'] ?? 0).toDouble(),
      turler: List<String>.from(json['turler'] ?? []),
      oyuncular: List<String>.from(json['oyuncular'] ?? []),
      yonetmen: json['yonetmen'] ?? "",
      yil: json['vizyonYili'] ?? 0,
    );
  }
}

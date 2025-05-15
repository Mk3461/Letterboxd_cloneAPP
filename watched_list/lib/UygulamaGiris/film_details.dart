import 'package:flutter/material.dart';
import '../Models/colorspallette.dart';
import '../Models/film.dart';

class FilmDetails extends StatelessWidget {
  final Film film;

  const FilmDetails({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // POSTER
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  film.filmResim ?? 'https://via.placeholder.com/300x200?text=No+Image',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black.withOpacity(0.6),
                  child: Icon(Icons.play_arrow, size: 50, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // IMDB PUANI
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5),
                  Text("IMDB: ${film.imdbPuani}", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // FİLM HAKKINDA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Film Hakkında",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: TC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                film.ozet ?? "Açıklama bulunamadı.",
                style: TextStyle(fontSize: 16, color: TC),
              ),
            ),

            // KATEGORİLER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Kategoriler",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: TC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                children: film.turler
                    .map((tur) => Chip(label: Text(tur)))
                    .toList(),
              ),
            ),

            const SizedBox(height: 16),

            // BAŞROL OYUNCULARI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Başrol Oyuncuları",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: TC),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: film.oyuncular.map((oyuncu) => Text("- $oyuncu")).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // YÖNETMEN VE YIL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.movie_creation_outlined),
                  const SizedBox(width: 8),
                  Text("Yönetmen: ${film.yonetmen}", style: TextStyle(color: TC)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text("Yapım Yılı: ${film.yil}", style: TextStyle(color: TC)),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

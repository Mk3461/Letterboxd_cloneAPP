import 'package:flutter/material.dart';
import '../Models/colorspallette.dart';
import '../Models/film.dart';

class SearchResultScreen extends StatelessWidget {
  final String genre;
  final List<Film> results;

  const SearchResultScreen({required this.genre, required this.results, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        backgroundColor: ABC,
        title: Text(
          '$genre filmleri',
          style: TextStyle(
            color: TC,
          ),
        ),
      ),
      body: results.isEmpty
          ? Center(
              child: Text(
                'Bu türe ait film bulunamadı.',
                style: TextStyle(
                  color: TC,
                ),
              ),
            )
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final film = results[index];
                return ListTile(
                  leading: film.filmResim != null
                      ? Image.network(film.filmResim!, width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.movie, size: 40, color: Colors.orange), // poster yerine geçici ikon
                  title: Text(film.film_adi ?? "Bilinmeyen", style: TextStyle(fontSize: 20)),
                  subtitle: Text('Tür: ${film.turler.join(', ')}', style: TextStyle(color: TC)),
                );
              },
            ),
    );
  }
}

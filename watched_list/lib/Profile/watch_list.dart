import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:watched_list/UygulamaGiris/film_details.dart';
import 'dart:convert';
import '../Models/global.dart' as global;
import '../Profile/movies_page.dart';
import '../Models/colorspallette.dart';
import '../Models/film.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  List<Film> watchlist = [];

  @override
  void initState() {
    super.initState();
    getWatchlist();
  }

  Future<void> getWatchlist() async {
    final url = Uri.parse(
        'http://10.0.2.2:5001/api/watchlist/listele?kullaniciId=${global.currentUserId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        watchlist = jsonData.map((data) => Film.fromJson(data)).toList();
      });
    } else {
      print("Watchlist çekilemedi: ${response.body}");
    }
  }

  Future<void> filmEkle(Film film) async {
    final isAlreadyAdded = watchlist.any((f) => f.id == film.id);
    if (isAlreadyAdded) {
      print("Film zaten watchlist'te");
      return;
    }

    final url = Uri.parse('http://10.0.2.2:5001/api/watchlist/ekle');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "kullaniciId": global.currentUserId,
        "filmId": film.id,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        watchlist.add(film);
      });
    } else {
      print("Watchlist'e ekleme başarısız: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        title: Text("WatchList", style: TextStyle(color: TC)),
        backgroundColor: ABC,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    itemCount: watchlist.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final film = watchlist[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilmDetails(film: film),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(1, 3),
                                ),
                              ],
                            ),
                            child: film.filmResim != null
                                ? Image.network(
                                    film.filmResim!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Center(child: Icon(Icons.broken_image)),
                                  )
                                : Center(
                                    child: Icon(Icons.image_not_supported)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () async {
                final selectedFilm = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MoviesPage()),
                );

                if (selectedFilm != null && selectedFilm is Film) {
                  await filmEkle(selectedFilm);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A1D3E), // Lacivert arka plan
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Yuvarlatılmış köşe
                ),
                padding: const EdgeInsets.all(18),
              ),
              child: Icon(
                Icons.add,
                color: Color(0xFF9C5EFF), // Mor renkli artı ikonu
                size: 28,
              ),
            ),
          )
        ],
      ),
    );
  }
}

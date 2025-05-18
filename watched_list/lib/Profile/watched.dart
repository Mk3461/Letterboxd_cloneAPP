import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:watched_list/Models/global.dart' as global;
import 'package:watched_list/Profile/movies_page.dart';
import '../Models/colorspallette.dart';
import '../Models/film.dart';

class Watched extends StatefulWidget {
  const Watched({super.key});

  @override
  State<Watched> createState() => _WatchedState();
}

class _WatchedState extends State<Watched> {
  List<Film> watchedList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getWatchedList();
  }

  Future<void> getWatchedList() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://10.0.2.2:5001/api/watchedlist/listele?kullaniciId=${global.currentUserId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        watchedList = jsonData.map((data) => Film.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print("Watched list çekilemedi: ${response.body}");
    }
  }

  Future<void> filmEkle(Film film) async {
    final isAlreadyAdded = watchedList.any((f) => f.id == film.id);
    if (isAlreadyAdded) {
      print("Film zaten watched listte");
      return;
    }

    final url = Uri.parse('http://10.0.2.2:5001/api/watchedlist/ekle');
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
        watchedList.add(film);
      });
    } else {
      print("Watched liste ekleme başarısız: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        title: Text("Watched", style: TextStyle(color: TC)),
        backgroundColor: ABC,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : watchedList.isEmpty
              ? const Center(child: Text('Henüz izlenen film yok'))
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: watchedList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final film = watchedList[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          boxShadow: const [
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
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(child: Icon(Icons.broken_image)),
                              )
                            : const Center(child: Icon(Icons.image_not_supported)),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: BC,
        onPressed: () async {
          final selectedFilm = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MoviesPage()),
          );

          if (selectedFilm != null && selectedFilm is Film) {
            await filmEkle(selectedFilm);
          }
        },
        child: const Icon(Icons.add_box, size: 30),
      ),
    );
  }
}

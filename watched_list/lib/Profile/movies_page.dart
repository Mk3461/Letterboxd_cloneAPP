import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:watched_list/Models/colorspallette.dart';
import 'package:watched_list/Models/film.dart'; 

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  List<Film> filmler = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFilms();
  }

  Future<void> fetchFilms() async {
    final url = Uri.parse('http://10.0.2.2:5001/api/film/all');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          filmler = jsonData.map((film) => Film.fromJson(film)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Filmler alınamadı');
      }
    } catch (e) {
      print('Hata: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        backgroundColor: ABC,
        title: Text("Movies", style: TextStyle(color: TC)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: filmler.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final film = filmler[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, film);
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
                                errorBuilder: (context, error, stackTrace) =>
                                    Center(child: Icon(Icons.broken_image)),
                              )
                            : Center(child: Icon(Icons.image_not_supported)),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

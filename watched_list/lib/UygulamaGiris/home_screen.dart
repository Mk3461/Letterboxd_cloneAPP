import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/colorspallette.dart';
import '../Profile/profil_sayfasi.dart';
import '../UygulamaGiris/film_details.dart';
import '../AramaSayfalari/search_main_page.dart';
import '../Models/film.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Map<String, List<Film>> categorizedFilms = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFilms();
  }

  Future<void> fetchFilms() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5001/api/film/all'));

    if (response.statusCode == 200) {
      final List<dynamic> filmJson = json.decode(response.body);
      final List<Film> films =
          filmJson.map((json) => Film.fromJson(json)).toList();

      Map<String, List<Film>> categoryMap = {};
      for (var film in films) {
        for (var tur in film.turler) {
          if (!categoryMap.containsKey(tur)) {
            categoryMap[tur] = [];
          }
          categoryMap[tur]!.add(film);
        }
      }

      setState(() {
        categorizedFilms = categoryMap;
        isLoading = false;
      });
    } else {
      print('Film verisi alınamadı: ${response.statusCode}');
    }
  }

  Widget buildCategory(String title, List<Film> films) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            title,
            style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: TC),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: films.length,
            itemBuilder: (context, index) {
              final film = films[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FilmDetails(film: film)),
                  );
                },
                child: Container(
                  width: 130,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Image.network(
                    film.filmResim ??
                        'https://via.placeholder.com/150x220?text=No+Image',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: BNBC,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfilSayfasi(username: widget.username)),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SearchScreen(username: widget.username)),
              );
            }
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Anasayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Ara'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Popüler Carousel
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Popular This Week',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: TC),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: PageView.builder(
                        itemBuilder: (_, index) {
                          final popList =
                              categorizedFilms.values.expand((x) => x).toList();
                          final film =
                              index < popList.length ? popList[index] : null;

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: GestureDetector(
                                onTap: () {
                                  if (film != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              FilmDetails(film: film)),
                                    );
                                  }
                                },
                                child: film != null
                                    ? Image.network(
                                        film.filmResim ??
                                            'https://via.placeholder.com/300x200?text=No+Image',
                                        fit: BoxFit.cover,
                                      )
                                    : Container(color: Colors.grey),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),

                    // Dinamik Kategoriler
                    for (var entry in categorizedFilms.entries)
                      buildCategory(entry.key, entry.value),
                  ],
                ),
              ),
      ),
    );
  }
}

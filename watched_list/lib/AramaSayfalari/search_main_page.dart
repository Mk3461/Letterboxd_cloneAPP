import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:watched_list/Profile/profil_sayfasi.dart';
import 'dart:convert';

import '../UygulamaGiris/home_screen.dart';
import 'search_result_screen.dart';
import 'lucky_screen.dart';
import '../Models/colorspallette.dart';
import '../Models/film.dart';

class SearchScreen extends StatefulWidget {
  final String username;
  const SearchScreen({Key? key, required this.username}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Film> filmListesi = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFilmler();
  }

  Future<void> _fetchFilmler() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:5001/api/film/all"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        filmListesi = data.map((filmJson) => Film.fromJson(filmJson)).toList();
        isLoading = false;
      });
    } else {
      // Hata yönetimi
      print("Film verileri çekilemedi.");
    }
  }

  void _openLuckyScreen() async {
    final response = await http.get(
        Uri.parse("http://10.0.2.2:5001/api/film/random")); // örnek endpoint

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final randomFilm = Film.fromJson(data);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LuckyScreen(film: randomFilm),
        ),
      );
    } else {
      print("Rastgele film çekilemedi.");
    }
  }

  void _searchByQuery(String query) {
    final queryLower = query.toLowerCase();
    final results = filmListesi.where((film) {
      final ad = film.film_adi?.toLowerCase() ?? '';
      final turler = film.turler.join(',').toLowerCase();
      return ad.contains(queryLower) || turler.contains(queryLower);
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SearchResultScreen(genre: query, results: results),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;

    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        backgroundColor: ABC,
        title: TextField(
          controller: _searchController,
          decoration:
              const InputDecoration(hintText: "Film adı ya da türü yaz..."),
          onSubmitted: _searchByQuery,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: BNBC,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen(username: widget.username)),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfilSayfasi(username: widget.username)),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: GestureDetector(
                onTap: _openLuckyScreen,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: BGC,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/Lucky.jpeg',
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'NE FİLM SEÇSEM',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: TC,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

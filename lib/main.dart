import 'package:flutter/material.dart';
import 'search_result_screen.dart';
import 'lucky_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film Önerici',
      theme: ThemeData.dark(),
      home: SearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> filmListesi = [
    {'ad': 'Inception', 'tur': 'bilim kurgu'},
    {'ad': 'The Matrix', 'tur': 'bilim kurgu'},
    {'ad': 'Interstellar', 'tur': 'bilim kurgu'},
    {'ad': 'Parasite', 'tur': 'dram'},
    {'ad': 'The Godfather', 'tur': 'suç'},
    {'ad': 'Forrest Gump', 'tur': 'komedi'},
    {'ad': 'Joker', 'tur': 'dram'},
    {'ad': 'Tenet', 'tur': 'bilim kurgu'},
    {'ad': 'Pulp Fiction', 'tur': 'suç'},
  ];

  void _openLuckyScreen() {
    filmListesi.shuffle();
    final randomFilm = filmListesi.first['ad']!;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LuckyScreen(filmAdi: randomFilm),
      ),
    );
  }

  void _searchByQuery(String query) {
    final results = filmListesi.where((film) {
      final queryLower = query.toLowerCase();
      final filmAdi = film['ad']!.toLowerCase();
      final filmTuru = film['tur']!.toLowerCase();
      return filmAdi.contains(queryLower) || filmTuru.contains(queryLower);
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
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(hintText: "Film adı ya da türü yaz..."),
          onSubmitted: _searchByQuery,
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _openLuckyScreen,
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'I feel lucky',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

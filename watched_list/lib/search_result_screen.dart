import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  final String genre;
  final List<Map<String, String>> results;

  const SearchResultScreen({required this.genre, required this.results, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$genre filmleri'),
      ),
      body: results.isEmpty
          ? Center(child: Text('Bu türe ait film bulunamadı.'))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final film = results[index];
                return ListTile(
                  leading: Icon(Icons.movie, size: 40, color: Colors.orange), // poster yerine geçici ikon
                  title: Text(film['ad']!, style: TextStyle(fontSize: 20)),
                  subtitle: Text('Tür: ${film['tur']}'),
                );
              },
            ),
    );
  }
}

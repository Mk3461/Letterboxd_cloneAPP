import 'dart:convert';
import 'package:watched_list/Models/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:watched_list/Models/colorspallette.dart';
import 'package:watched_list/UygulamaGiris/film_list.dart';

class Likes extends StatefulWidget {
  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  List<dynamic> likedMovies = [];
  bool isLoading = true;
  String? error;

  final String apiUrl =
      "http://10.0.2.2:5001/api/LikedList/user/${global.currentUserId}";

  @override
  void initState() {
    super.initState();
    fetchLikedMovies();
  }

  Future<void> fetchLikedMovies() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          likedMovies = data;
          isLoading = false;
          error = null;
        });
      } else {
        setState(() {
          error = "Sunucudan veri alınamadı: ${response.statusCode}";
          print("Kullanıcı ID: ${global.currentUserId}");
          print("İstek atılan URL: $apiUrl");
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = "Bir hata oluştu: $e";
        isLoading = false;
      });
    }
  }
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ABC,
        title: Row(
          children: [
            Icon(Icons.favorite, color: Colors.deepPurple),
            const SizedBox(width: 8),
            Text(
              "Likes",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: TC,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : error != null
                ? Center(child: Text(error!))
                : likedMovies.isEmpty
                    ? Center(child: Text("Beğenilen film bulunamadı"))
                    : GridView.builder(
                        itemCount: likedMovies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          final film = likedMovies[index];
                          final imageUrl = film['filmResim'] ?? '';

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(1, 3),
                                  )
                                ],
                              ),
                              child: imageUrl.isNotEmpty
                                  ? Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Center(
                                              child: Icon(Icons.broken_image)),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    )
                                  : Center(
                                      child: Icon(Icons.image_not_supported)),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}
*/
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: BGC,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: ABC,
      title: Row(
        children: [
          Icon(Icons.favorite, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Text(
            "Likes",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: TC,
            ),
          ),
        ],
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : likedMovies.isEmpty
                  ? Center(child: Text("Beğenilen film bulunamadı"))
                  : GridView.builder(
                      itemCount: likedMovies.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final film = likedMovies[index];
                        final imageUrl = film['filmResim'] ?? '';

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(1, 3),
                                )
                              ],
                            ),
                            child: imageUrl.isNotEmpty
                                ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Center(child: Icon(Icons.broken_image)),
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(child: CircularProgressIndicator());
                                    },
                                  )
                                : Center(child: Icon(Icons.image_not_supported)),
                          ),
                        );
                      },
                    ),
    ),
    floatingActionButton: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FilmList()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: BC, // Buton rengi
        shape: CircleBorder(),
        padding: EdgeInsets.all(16),
      ),
      child: Icon(Icons.add_box, size: 30),
    ),
  );
}
}

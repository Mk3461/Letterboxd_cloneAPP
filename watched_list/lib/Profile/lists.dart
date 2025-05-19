import 'package:flutter/material.dart';
import 'package:watched_list/Models/film.dart';
import 'package:watched_list/Models/global.dart' as global;
import 'package:watched_list/Profile/movies_page.dart';
import 'package:watched_list/Models/colorspallette.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:watched_list/UygulamaGiris/film_details.dart';

class Liste {
  final String listName;
  final List<Film> filmler;

  Liste({required this.listName, required this.filmler});
}

class Lists extends StatefulWidget {
  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  List<Liste> listeler = [];

  final String baseUrl = "http://10.0.2.2:5001/api/Liste";

  bool listedeSecilenMovieVarMi(Liste secilenListe, int movieId) {
    return secilenListe.filmler.any((f) => f.id == movieId);
  }

  Future<List<String>> fetchUserListNames(int kullaniciId) async {
    final url = Uri.parse("$baseUrl/kullanici-listeleri/$kullaniciId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.cast<String>();
    } else {
      throw Exception("Liste isimleri alınamadı");
    }
  }

  Future<List<Film>> fetchFilmsFromList(
      int kullaniciId, String listeAdi) async {
    final url = Uri.parse("$baseUrl/liste/$kullaniciId/$listeAdi");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Film.fromJson(json)).toList();
    } else {
      throw Exception("Liste filmleri alınamadı");
    }
  }

  Future<String?> filmListeyeEkle({
    required int? kullaniciId,
    required String listeAdi,
    required int filmId,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/film-ekle");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "KullaniciId": kullaniciId,
          "ListeAdi": listeAdi,
          "FilmId": filmId,
        }),
      );

      if (response.statusCode == 200) {
        return null; // Başarılı
      } else {
        return response.body;
      }
    } catch (e) {
      return "HTTP Hatası: $e";
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserLists();
  }

  Future<void> loadUserLists() async {
    try {
      int? kullaniciId = global.currentUserId;
      final listeAdlari = await fetchUserListNames(kullaniciId!);

      List<Liste> tempListeler = [];
      for (var listeAdi in listeAdlari) {
        final filmler = await fetchFilmsFromList(kullaniciId, listeAdi);
        tempListeler.add(Liste(listName: listeAdi, filmler: filmler));
      }

      setState(() {
        listeler = tempListeler;
      });
    } catch (e) {
      print("Liste yüklenirken hata: $e");
    }
  }

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
              "Lists",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: TC,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final secilenFilm = await Navigator.push<Film>(
            context,
            MaterialPageRoute(builder: (context) => MoviesPage()),
          );

          if (secilenFilm != null) {
            showDialog(
              context: context,
              builder: (context) {
                String? seciliListeAdi;
                TextEditingController controller = TextEditingController();

                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  title: Text(
                    "Liste Seç veya Oluştur",
                    style: TextStyle(fontWeight: FontWeight.bold, color: TC),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Mevcut Listeler",
                          labelStyle: TextStyle(color: TC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        value: null,
                        items: listeler.map((liste) {
                          return DropdownMenuItem<String>(
                            value: liste.listName,
                            child: Text(liste.listName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          seciliListeAdi = value;
                        },
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: "Yeni Liste Adı",
                          labelStyle: TextStyle(color: TC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: Icon(Icons.create_new_folder_outlined),
                        ),
                      ),
                    ],
                  ),
                  actionsPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        backgroundColor: BC,
                      ),
                      child: Text(
                        "İptal",
                        style: TextStyle(color: TC),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        String yeniListeAdi = controller.text.trim();
                        String? kullanilacakListeAdi = yeniListeAdi.isNotEmpty
                            ? yeniListeAdi
                            : seciliListeAdi;

                        if (kullanilacakListeAdi != null) {
                          final hataMesaji = await filmListeyeEkle(
                            kullaniciId: global.currentUserId,
                            listeAdi: kullanilacakListeAdi,
                            filmId: secilenFilm.id,
                          );

                          if (hataMesaji != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  hataMesaji,
                                  style: TextStyle(color: Colors.white),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.redAccent.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                            return;
                          }

                          // Başarılıysa local state'i güncelle
                          setState(() {
                            final mevcutListe = listeler.firstWhere(
                              (liste) => liste.listName == kullanilacakListeAdi,
                              orElse: () {
                                final yeniListe = Liste(
                                    listName: kullanilacakListeAdi!,
                                    filmler: []);
                                listeler.add(yeniListe);
                                return yeniListe;
                              },
                            );

                            if (!listedeSecilenMovieVarMi(
                                mevcutListe, secilenFilm.id)) {
                              mevcutListe.filmler.add(secilenFilm);
                            }
                          });

                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(Icons.add),
                      label: Text(
                        "Ekle",
                        style: TextStyle(color: TC),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BC,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
        backgroundColor: BC,
        child: Icon(Icons.add, size: 32),
      ),
      body: listeler.isEmpty
          ? Center(
              child: Text(
                "Liste bulunamadı veya yükleniyor...",
                style: TextStyle(color: TC),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: listeler.length,
              itemBuilder: (context, index) {
                final liste = listeler[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      liste.listName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: TC,
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: liste.filmler.length,
                        separatorBuilder: (_, __) => SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          final film = liste.filmler[i];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FilmDetails(film: film)));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 120,
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
                                child: film.filmResim != null
                                    ? Image.network(film.filmResim!,
                                        fit: BoxFit.cover)
                                    : Center(child: Icon(Icons.movie)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

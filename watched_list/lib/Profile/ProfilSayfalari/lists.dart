import 'package:flutter/material.dart';
import 'package:watched_list/Profile/ProfilSayfalari/moviesPage.dart';
import 'package:watched_list/Profile/data.dart';
class Lists extends StatefulWidget {
  @override
  State<Lists> createState() => _LikesState();
}

class _LikesState extends State<Lists> {
  List<Data> Listeler = [];

  bool listedeSecilenMovieVarMi(Data secilenListe, String movie) {
    return secilenListe.imageWay.contains(movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            Icon(Icons.favorite ,color: Colors.deepPurple),
            const SizedBox(width: 8),
            const Text(
              "Lists",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final secilenResim = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Moviespage()),
          );

          if (secilenResim != null) {
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Mevcut Listeler",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        value: null,
                        items: Listeler.map((liste) {
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: Icon(Icons.create_new_folder_outlined),
                        ),
                      ),
                    ],
                  ),
                  actionsPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                      ),
                      child: Text("İptal"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        String yeniListeAdi = controller.text.trim();
                        String? kullanilacakListeAdi = yeniListeAdi.isNotEmpty
                            ? yeniListeAdi
                            : seciliListeAdi;

                        if (kullanilacakListeAdi != null) {
                          setState(() {
                            final mevcutListe = Listeler.firstWhere(
                              (liste) => liste.listName == kullanilacakListeAdi,
                              orElse: () => Data(kullanilacakListeAdi, []),
                            );

                            if (!Listeler.contains(mevcutListe)) {
                              Listeler.add(mevcutListe);
                            }

                            if (listedeSecilenMovieVarMi(mevcutListe, secilenResim)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Bu film zaten bu listede mevcut."),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.redAccent.shade200,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                              return;
                            }

                            mevcutListe.imageWay.add(secilenResim);
                          },);

                          Navigator.pop(context); // dialog kapat
                        }
                      },
                      icon: Icon(Icons.add),
                      label: Text("Ekle"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
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
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, size: 32),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: Listeler.length,
        itemBuilder: (context, index) {
          final liste = Listeler[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                liste.listName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: liste.imageWay.length,
                  separatorBuilder: (context, i) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    return ClipRRect(
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
                        child: Image.asset(
                          liste.imageWay[i],
                          fit: BoxFit.cover,
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

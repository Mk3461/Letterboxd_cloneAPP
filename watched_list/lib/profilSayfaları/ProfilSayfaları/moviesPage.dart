import 'package:flutter/material.dart';
import 'package:watched_list/profilSayfalar%C4%B1/ProfilSayfalar%C4%B1/data.dart';

class Moviespage extends StatelessWidget {
  List<Data> listeler = [
    Data(
      "Drama",
      [
        "images/stelios.jpg",
        "images/derun.jpg",
        "images/djahmet.jpg",
        "images/theWitness.jpg"
      ],
    ),
    Data(
      "Komedi",
      [
        "images/nakedgun.jpg",
        "images/junej&jone.jpg",
        "images/tambanagore.jpg"
      ],
    ),
    Data(
      "BilimKurgu",
      [
        "images/yildizlararasi.jpg",
        "images/tron.jpg",
        "images/tenet.jpg",
        "images/baslangic.jpg",
        "images/amator.jpg",
        "images/IMG_6105.jpeg"
      ],
    ),
  ];

  // Tüm resimleri tek listeye düzleştiriyoruz
  List<String> getTumResimler() {
    return listeler.expand((kategori) => kategori.imageWay).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tumResimler = getTumResimler();
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: tumResimler.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Her satırda 3 görsel
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.7, // Görselin oranı
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.pop(context,tumResimler[index],);
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
                    )
                  ],
                ),
                child: Image.asset(
                  tumResimler[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),);
          },
        ),
      ),
    );
  }
}
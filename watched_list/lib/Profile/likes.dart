import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'data.dart';
=======
import '../Profile/data%2010.48.51.dart';
import '../colorspallette.dart';
>>>>>>> 2dba995 (FrontendDesignCompleted)

class Likes extends StatefulWidget {
  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
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
      //backgroundColor: Theme.of(context).colorScheme.background,
      backgroundColor: BGC,
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: Theme.of(context).colorScheme.background,
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
        child: GridView.builder(
          itemCount: tumResimler.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Her satırda 3 görsel
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.7, // Görselin oranı
          ),
          itemBuilder: (context, index) {
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
                child: Image.asset(
                  tumResimler[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

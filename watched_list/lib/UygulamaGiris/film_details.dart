import 'package:flutter/material.dart';
import '../colorspallette.dart';

class FilmDetails extends StatelessWidget {
  const FilmDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // POSTER VE PLAY BUTONU
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/Interstellar.png',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black.withOpacity(0.6),
                  child: Icon(Icons.play_arrow, size: 50, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // IMDB PUANI
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5),
                  Text("IMDB: 8.6", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // FİLM HAKKINDA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Film Hakkında",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: TC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Bir grup astronot, insanlığın geleceğini kurtarmak için galaksiler arası bir yolculuğa çıkar.",
                style: TextStyle(fontSize: 16,color: TC),
              ),
            ),

            // KATEGORİLER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Kategoriler",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: TC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                children: const [
                  Chip(label: Text("Bilim Kurgu"),),
                  Chip(label: Text("Dram")),
                  Chip(label: Text("Macera")),
                ],
              ),
            ),

            const SizedBox(height: 16),

            
            // BAŞROL OYUNCULARI
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
            "Başrol Oyuncuları",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: TC),
                ),
              ),
            const SizedBox(height: 8),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
            Text("- Matthew McConaughey"),
            Text("- Anne Hathaway"),
            Text("- Jessica Chastain"),
            Text("- Michael Caine"),
            Text("- Nurullah Özgenç")
              ],
            ),
            ),

            const SizedBox(height: 16),

            // YÖNETMEN VE YAPIM YILI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.movie_creation_outlined),
                  const SizedBox(width: 8),
                  Text("Yönetmen: Christopher Nolan",
                  style: TextStyle(color: TC),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text("Yapım Yılı: 2014",
                  style: TextStyle(
                    color: TC,
                  ),),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}


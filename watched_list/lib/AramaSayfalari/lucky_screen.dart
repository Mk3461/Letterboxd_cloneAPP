import 'package:flutter/material.dart';
import 'package:watched_list/Models/colorspallette.dart';
import 'package:watched_list/Models/film.dart';

class LuckyScreen extends StatelessWidget {
  final Film film;

  const LuckyScreen({required this.film, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        backgroundColor: ABC,
        title: Text(
          'I Feel Lucky',
          style: TextStyle(color: TC),
        ),
        leading: BackButton(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              film.filmResim != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        film.filmResim!,
                        width: 250,
                        height: 350,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Icons.movie, size: 150, color: Colors.orange),
              const SizedBox(height: 20),
              Text(
                film.film_adi ?? "Bilinmeyen",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: TC),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Tür: ${film.turler.join(', ')}',
                style: TextStyle(fontSize: 18, color: TC),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

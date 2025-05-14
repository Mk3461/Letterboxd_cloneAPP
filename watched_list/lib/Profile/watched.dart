import 'package:flutter/material.dart';
import '../UygulamaGiris/film_list.dart';
import '../colorspallette.dart';


class Watched extends StatefulWidget {
  const Watched({super.key});

  @override
  State<Watched> createState() => _WatchListState();
}

class _WatchListState extends State<Watched> {
  var filmliste = [
    "assets/forrestGump.png",
    "assets/Interstellar.png",
    "assets/ItsAWonderfulLife.png",
    "assets/GreenMile.png",
    "assets/BabamVeOglum.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
        appBar: AppBar(
          title: Text("Watched",
          style: TextStyle(color: TC),),
          backgroundColor:ABC,
            ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: filmliste
                    .map((film) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(film),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 5), // Buton ile GridView arasında boşluk bırakır
            ElevatedButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder:(context)=>FilmList()));
              },            
                style: ElevatedButton.styleFrom(
                backgroundColor:BC, // Buton rengi
                iconSize:30, 
              ),
              child:Icon(Icons.add_box),
            ),
          ],
        ),
    );
  }
}
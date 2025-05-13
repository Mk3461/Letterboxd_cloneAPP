import 'package:flutter/material.dart';
import '../UygulamaGiris/film_list.dart';


class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  var filmliste = [
    "assets/forrestGump.png",
    "assets/Interstellar.png",
    "assets/ItsAWonderfulLife.png",
    "assets/ThePianist.png",
    "assets/GreenMile.png",
    "assets/BabamVeOglum.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WatchList"),
          backgroundColor: const Color.fromARGB(255, 50, 4, 0),
          foregroundColor: const Color.fromARGB(255, 11, 136, 238),
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
                backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Buton rengi
                iconSize:30, 
              ),
              child:Icon(Icons.add_box),
            ),
          ],
        ),
    );
  }
}
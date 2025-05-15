import 'package:flutter/material.dart';
import '../UygulamaGiris/film_list.dart';
import '../Models/colorspallette.dart';


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
      backgroundColor: BGC,
        appBar: AppBar(
          title: Text("WatchList",
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
                backgroundColor: BC, // Buton rengi
                iconSize:30, 
              ),
              child:Icon(Icons.add_box),
            ),
          ],
        ),
    );
  }
}
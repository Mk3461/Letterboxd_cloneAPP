
import 'package:flutter/material.dart';

void main(){
  runApp(FilmList());
}
class FilmList extends StatefulWidget {
  const FilmList({super.key});

  @override
  State<FilmList> createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
var seciliFilm = "";
var seciliIndex = -1;
var filmListesi =[
"Shawshank Redemption",
"12 Angry Men",
"Forest Gump",
"Interstellar",
"It's A Wonderful Life",
"The Silence Of The Lamb",
"Green Mile",
"Life is Beautiful",
"The Pianist",
"Babam Ve Oglum",
"Psycho",
"Se7en",
"The Usual Suspects",
"Memento",

];
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filmListesi.length,
              itemBuilder: (context, i) => ListTile(
                title: Text(filmListesi[i]),
                onTap: () {
                  setState(() {
                    seciliFilm = filmListesi[i];
                    seciliIndex = i;
                  });
                  },
                selected: i == seciliIndex,
                selectedTileColor: Colors.blue,
                selectedColor: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context,seciliFilm);
            },
            child: Text("Filmi Onayla"),
          ),
        ],
      ),
    );
  }
}
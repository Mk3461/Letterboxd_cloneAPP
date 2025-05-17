import 'package:flutter/material.dart';
import 'package:watched_list/Profile/settings.dart';
import '../AramaSayfalari/search_main_page.dart';
import '../Profile/likes.dart';
import '../Profile/watch_list.dart';
import '../Profile/watched.dart';
import '../Profile/lists.dart';
import '../UygulamaGiris/home_screen.dart';
import '../Models/colorspallette.dart';

class ProfilSayfasi extends StatefulWidget {
  final String username;
  const ProfilSayfasi({Key? key,required this.username}) : super(key: key);

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  final List<_MenuSecenekleri> menuSecenekleri = const [
    _MenuSecenekleri("Likes", Icons.favorite),
    _MenuSecenekleri("Lists", Icons.list),
    _MenuSecenekleri("WatchList", Icons.bookmark),
    _MenuSecenekleri("Settings", Icons.settings),
    _MenuSecenekleri("Watched", Icons.visibility),
  ];


  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 2;
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        backgroundColor: ABC,
        title:  Text(widget.username,style: TextStyle(color:TC),),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
              'assets/eralpinho.jpeg',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor:BNBC,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen(username: widget.username,)));
            }
            //Mustafa search ekranı
            else if (index == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(username: widget.username,)));
            } 
            }
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Anasayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Ara'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: menuSecenekleri.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = menuSecenekleri[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(item.icon, color: Colors.deepPurple),
              title: Text(item.title, style: TextStyle(fontSize: 16,color: TC)),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                switch (item.title) {
                  case "Likes":
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Likes()),
                    );
                    break;
                  case "Lists":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Lists(),
                      )
                    );
                    break;
                  case "WatchList":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WatchList(),
                      ));
                      break;
                  case "Watched":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Watched(),
                      ));
                      case "Settings":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Settings(),
                      ));
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class _MenuSecenekleri {
  final String title;
  final IconData icon;

  const _MenuSecenekleri(this.title, this.icon);
}

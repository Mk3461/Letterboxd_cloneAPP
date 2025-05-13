import 'package:flutter/material.dart';
import '../AramaSayfalari/search_main_page.dart';
import '../Profile/profil_sayfasi.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({Key? key, required this.username}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> dummyImages = List.generate(10, (index) => 'https://via.placeholder.com/150x220?text=Film+${index + 1}');

  Widget buildCategory(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dummyImages.length,
            itemBuilder: (context, index) {
              return Container(
                width: 130,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Image.network(dummyImages[index], fit: BoxFit.cover),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Color(0xFF800000),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          
          setState(() {
            _selectedIndex = index;
            if(index ==2){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilSayfasi(username: widget.username)));
            }
            //Mustafa search ekranı
            else if (index==1){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(username: widget.username,)));
            }

          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Anasayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Ara'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil',),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "Popular this week" carousel
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Popular This Week',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 250,
                child: PageView.builder(
                  itemCount: 5,
                  controller: PageController(viewportFraction: 0.8),
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://via.placeholder.com/300x200?text=Popüler+${index + 1}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),

              // Kategoriler
              buildCategory('Dram'),
              buildCategory('Plot Twist'),
              buildCategory('Bilim Kurgu'),
              buildCategory('War'),
              buildCategory('Action'),
              buildCategory('Mafia/Gangster'),
              buildCategory('Komedi'),
              buildCategory('Korku'),
              buildCategory('Biography'),
            ],
          ),
        ),
      ),
    );
  }
}
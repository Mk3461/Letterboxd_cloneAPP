import 'package:flutter/material.dart';
import 'package:watched_list/sayfa10/Sayfa10/likes.dart';
import 'package:watched_list/sayfa10/Sayfa10/lists.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ProfilSayfasi(),
    );
  }
}

class ProfilSayfasi extends StatelessWidget {
  const ProfilSayfasi({Key? key}) : super(key: key);

  final List<_MenuSecenekleri> menuSecenekleri = const [
    _MenuSecenekleri("Likes", Icons.favorite),
    _MenuSecenekleri("Lists", Icons.list),
    _MenuSecenekleri("Watchlist", Icons.bookmark),
    _MenuSecenekleri("Settings", Icons.settings),
    _MenuSecenekleri("Watched", Icons.visibility),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kullanıcı Adı"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("images/IMG_6105.jpeg"),
          ),
        ),
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
              title: Text(item.title, style: TextStyle(fontSize: 16)),
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
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> Lists()));
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
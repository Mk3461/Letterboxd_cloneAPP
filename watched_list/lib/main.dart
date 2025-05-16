import 'package:flutter/material.dart';
import 'package:watched_list/AramaSayfalari/search_main_page.dart';
import 'package:watched_list/Profile/profil_sayfasi.dart';
import '../UygulamaGiris/splash_screen.dart';

void main() {
  runApp(Proje());
}

class Proje extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Demo',
      //home: SplashScreen(),
      home: ProfilSayfasi(username: "Murat",),
      debugShowCheckedModeBanner: false,
    );
  }
}






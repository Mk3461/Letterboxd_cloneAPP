import 'package:flutter/material.dart';
import '../UygulamaGiris/splash_screen.dart';

void main() {
  runApp(Proje());
}

class Proje extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Demo',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}






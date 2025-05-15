import 'dart:async';
import 'package:flutter/material.dart';
import '../UygulamaGiris/login_screen.dart';
import '../Models/colorspallette.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen>  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 15 saniye bekleyip LoginScreen'e yönlendir
    Timer(Duration(seconds: 12), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 255, 255, 255),
      backgroundColor:BGC,
      body: Center(
       child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/HamsiPNG.png', // Splash ekranı için resim
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'HVGFlix',
                style: TextStyle(
                  color: TC,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Text(
              'İftiharla',
              style: TextStyle(
                color: TC,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Sunar...',
                style: TextStyle(
                  color: TC,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
       ),
      ),
    );
  }
}
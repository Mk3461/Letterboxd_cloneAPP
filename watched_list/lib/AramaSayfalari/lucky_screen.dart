import 'package:flutter/material.dart';

class LuckyScreen extends StatelessWidget {
  final String filmAdi;

  const LuckyScreen({required this.filmAdi, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('I feel lucky'),
        leading: BackButton(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie, size: 100),
            SizedBox(height: 20),
            Text(
              filmAdi,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

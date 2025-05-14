import 'package:flutter/material.dart';
import '../colorspallette.dart';

class LuckyScreen extends StatelessWidget {
  final String filmAdi;

  const LuckyScreen({required this.filmAdi, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        backgroundColor: ABC,
        title: Text('I Feel Lucky',
        style: TextStyle(
          color: TC,
        ),),
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
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: TC),
            ),
          ],
        ),
      ),
    );
  }
}

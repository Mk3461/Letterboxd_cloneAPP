import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:watched_list/Models/global.dart' as global;

import '../UygulamaGiris/home_screen.dart';
import '../UygulamaGiris/register_screen.dart';
import '../Models/colorspallette.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<Map<String, String>> registeredUsers = [];

  @override
  void initState() {
    super.initState();
  }


  void login() async {
  var username = usernameController.text.trim();
  var password = passwordController.text;

  if (username.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lütfen kullanıcı adı ve şifre girin')),
    );
    return;
  }

  try {
    var response = await http.post(
      Uri.parse('http://10.0.2.2:5001/api/kullanici/giris'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'kullaniciAdi': username,
        'sifre': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        global.currentUserId = data['userId'];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(username: username)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Giriş başarısız')),
        );
      }
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kullanıcı adı veya şifre yanlış')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sunucu hatası: ${response.statusCode}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bağlantı hatası: $e')),
    );
  }
}


  void goToRegister() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RegisterScreen()),
    );

    if (result != null && result is Map) {
      setState(() {
        registeredUsers.add({
          'username': result['username'],
          'password': result['password'],
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        title: Text(
          'Giriş Yap',
          style: TextStyle(color: TC),
        ),
        backgroundColor: ABC,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                )),
            SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Şifre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: BC,
              ),
              child: Text('Giriş Yap', style: TextStyle(color: TC)),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: goToRegister,
              child: Text(
                'Hesabınız yok mu? Kayıt olun',
                style: TextStyle(
                    color: TC, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

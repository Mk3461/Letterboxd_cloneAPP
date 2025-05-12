import 'package:flutter/material.dart';
import 'package:watched_list/HomeScreen.dart';
import 'package:watched_list/RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Başlangıçta kayıtlı kullanıcılar
  List<Map<String, String>> registeredUsers = [
    {'username': 'ufuk', 'password': '3929'},
    {'username': 'murat', 'password': '6161'},
    {'username': 'mustafa', 'password': '3522'},
    {'username': 'taha', 'password': '5942'},
  ];

  void login() {
    var username = usernameController.text.trim();
    var password = passwordController.text;

    var userFound = registeredUsers.any((user) =>
        user['username'] == username && user['password'] == password);

    if (userFound) { 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(username: username,)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kullanıcı adınızı ya da şifrenizi yanlış girdiniz')),
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
      appBar: AppBar(
        title: Text('Giriş Yap'),
        backgroundColor: Color(0xFF800000)
        ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController, 
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı'
              )
            ),
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
                backgroundColor: Color(0xFF800000)
              ),
              child: Text('Giriş Yap'),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: goToRegister,
              child: Text(
                'Hesabınız yok mu? Kayıt olun',
                style: TextStyle(
                  color: Colors.blue, 
                  decoration: TextDecoration.underline
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

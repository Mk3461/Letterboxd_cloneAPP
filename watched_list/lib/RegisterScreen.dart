import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var usernameController = TextEditingController(); 
  var ageController = TextEditingController();
  var genderController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  void register() {
    var name = nameController.text.trim();
    var surname = surnameController.text.trim();
    var username = usernameController.text.trim();
    var age = ageController.text.trim();
    var gender = genderController.text.trim();
    var password = passwordController.text;
    var confirmPassword = confirmPasswordController.text;

    // Alanlar boş mu kontrolü
    if (name.isEmpty ||
        surname.isEmpty ||
        username.isEmpty ||
        age.isEmpty ||
        gender.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tüm alanları doldurun!')),
      );
      return;
    }

    // Şifre eşleşiyor mu kontrolü
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Şifre ve şifre tekrarı aynı olmalı!')),
      );
      return;
    }

    // Kayıt başarılı
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Başarıyla kayıt oldunuz!')),
    );

    // LoginScreen'e kullanıcı bilgilerini geri döndür
    Navigator.pop(context, {
      'username': username,
      'password': password,
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    usernameController.dispose();
    ageController.dispose();
    genderController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Ol'), 
        backgroundColor: Color(0xFF800000)
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController, 
                decoration: InputDecoration(
                  labelText: 'Ad'
                )
              ),
              SizedBox(height: 10),
              TextField(
                controller: surnameController, 
                decoration: InputDecoration(
                  labelText: 'Soyad'
                )
              ),
              SizedBox(height: 10),
              TextField(
                controller: usernameController, 
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı'
                )
              ),
              SizedBox(height: 10),
              TextField(
                controller: ageController, 
                decoration: InputDecoration(
                  labelText: 'Yaş'
                ),
                keyboardType: TextInputType.number
              ),
              SizedBox(height: 10),
              TextField(
                controller: genderController, 
                decoration: InputDecoration(
                  labelText: 'Cinsiyet'
                )
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController, 
                obscureText: true, 
                decoration: InputDecoration(
                  labelText: 'Şifre'
                )
              ),
              SizedBox(height: 10),
              TextField(
                controller: confirmPasswordController, 
                obscureText: true, 
                decoration: InputDecoration(
                  labelText: 'Şifre Tekrar'
                )
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF800000)
                ),
                child: Text('Kayıt Ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

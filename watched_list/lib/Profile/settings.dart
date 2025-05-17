import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watched_list/Profile/profil_sayfasi.dart';
import '../Models/colorspallette.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? selectedGender;
  var nameControllers = TextEditingController();
  var surnameControllers = TextEditingController();
  var usernameControllers = TextEditingController();
  var ageControllers = TextEditingController();
  var genderControllers = TextEditingController();
  var passwordControllers = TextEditingController();
  var confirmPasswordControllers = TextEditingController();


void update() async {
  var name = nameControllers.text.trim();
  var surname = surnameControllers.text.trim();
  var username = usernameControllers.text.trim();
  var age = ageControllers.text.trim();
  var password = passwordControllers.text;
  var confirmPassword = confirmPasswordControllers.text;
  var gender = selectedGender ?? "";
  Navigator.push(context,MaterialPageRoute(builder: (context) => ProfilSayfasi(username: '',),));

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Şifre ve şifre tekrarı aynı olmalı!')),
    );
    return;
  }

  var url = Uri.parse("http://10.0.2.2:5001/api/Kullanici/ekle"); 
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "kullaniciAdi": username,
      "isim": name,
      "soyisim": surname,
      "yas": int.parse(age),
      "cinsiyet": gender,
      "sifre": password
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bilgileriniz Güncellendi')),
    );
    Navigator.pop(context, {
      'username': username,
      'password': password,
    });
  }
}
  @override
  void dispose() {
    nameControllers.dispose();
    surnameControllers.dispose();
    usernameControllers.dispose();
    ageControllers.dispose();
    genderControllers.dispose();
    passwordControllers.dispose();
    confirmPasswordControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        title: Text(
          'Bilgilerini Güncelle',
          style: TextStyle(
            color: TC,
          ),
        ),
        backgroundColor: ABC,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              TextField(
                controller: nameControllers,
                decoration: InputDecoration(
                  labelText: 'Ad',
                  labelStyle: TextStyle(
                    color: TC,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-ZğüşöçİĞÜŞÖÇ\s]')),
                ],
              ),
              SizedBox(height: 20),
          
              TextField(
                controller: surnameControllers,
                decoration: InputDecoration(
                  labelText: 'Soyad',
                  labelStyle: TextStyle(
                    color: TC,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-ZğüşöçİĞÜŞÖÇ\s]')),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                  controller: usernameControllers,
                  decoration: InputDecoration(
                    labelText: 'Kullanıcı Adı',
                    labelStyle: TextStyle(
                      color: TC,
                    ),
                  )),
              SizedBox(height: 20),
              TextField(
                controller: ageControllers,
                decoration: InputDecoration(
                  labelText: 'Yaş',
                  labelStyle: TextStyle(
                    color: TC,
                  ),
                ),
                keyboardType:
                    TextInputType.number, 
                inputFormatters: [
                  FilteringTextInputFormatter
                      .digitsOnly, 
                ],
              ),

              SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(
                  labelText: 'Cinsiyet',
                  labelStyle: TextStyle(
                    color: TC, // Rengin neyse burada kullan
                  ),
                  border: OutlineInputBorder(), // opsiyonel
                ),
                items: ['Kadın', 'Erkek', 'Atak Helikopteri', 'Opsiyonel']
                    .map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
              ),

              SizedBox(height: 20),
              TextField(
                  controller: passwordControllers,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    labelStyle: TextStyle(
                      color: TC,
                    ),
                  )),
              SizedBox(height: 20),
              TextField(
                  controller: confirmPasswordControllers,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre Tekrar',
                    labelStyle: TextStyle(
                      color: TC,
                    ),
                  )),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed:update,
                style: ElevatedButton.styleFrom(
                  backgroundColor: BC,
                ),
                child: Text(
                  'Bilgileri Güncelle',
                  style: TextStyle(
                    color: TC,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Models/colorspallette.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectedGender;
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var usernameController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();


void register() async {
  var name = nameController.text.trim();
  var surname = surnameController.text.trim();
  var username = usernameController.text.trim();
  var age = ageController.text.trim();
  var password = passwordController.text;
  var confirmPassword = confirmPasswordController.text;
  var gender = selectedGender ?? ""; // dropdown'dan geliyor

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

  // Debug amaçlı 
  print('Status code: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Başarıyla kayıt oldunuz!')),
    );
    Navigator.pop(context, {
      'username': username,
      'password': password,
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Kayıt başarısız: [${response.statusCode}] ${response.body}',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
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
      backgroundColor: BGC,
      appBar: AppBar(
        title: Text(
          'Kayıt Ol',
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
              /*TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'Ad',
                      labelStyle: TextStyle(
                        color: TC,
                      ))),*/
              TextField(
                controller: nameController,
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
              /*TextField(
                controller: surnameController,
                decoration: InputDecoration(
                  labelText: 'Soyad',
                  labelStyle: TextStyle(
                    color: TC,
                  ),
                ),
              ),*/
              TextField(
                controller: surnameController,
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
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Kullanıcı Adı',
                    labelStyle: TextStyle(
                      color: TC,
                    ),
                  )),
              SizedBox(height: 20),
              /*TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Yaş',
                  labelStyle: TextStyle(
                    color: TC,
                  ),
                ),
                //  keyboardType: TextInputType.number
              ),*/
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Yaş',
                  labelStyle: TextStyle(
                    color: TC,
                  ),
                ),
                keyboardType:
                    TextInputType.number, // Sadece sayı klavyesi açılır
                inputFormatters: [
                  FilteringTextInputFormatter
                      .digitsOnly, // Sadece rakam kabul edilir
                ],
              ),

              SizedBox(height: 20),
              /*
              TextField(
                controller: genderController, 
                decoration: InputDecoration(
                  labelText: 'Cinsiyet',
                   labelStyle:TextStyle(
                    color: TC,
                   ),
                )
              ),
              */
              // Seçilen cinsiyet değeri (null olabilir)

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
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    labelStyle: TextStyle(
                      color: TC,
                    ),
                  )),
              SizedBox(height: 20),
              TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre Tekrar',
                    labelStyle: TextStyle(
                      color: TC,
                    ),
                  )),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: BC,
                ),
                child: Text(
                  'Kayıt Ol',
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

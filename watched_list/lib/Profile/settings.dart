import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watched_list/Models/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var passwordControllers = TextEditingController();
  var confirmPasswordControllers = TextEditingController();

  String? nameHint;
  String? surnameHint;
  String? usernameHint;
  String? ageHint;
  String? genderHint;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    final url =
        Uri.parse("http://10.0.2.2:5001/api/kullanici/${global.currentUserId}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        nameHint = data['isim'] ?? '';
        surnameHint = data['soyisim'] ?? '';
        usernameHint = data['kullanici_adi'] ?? '';
        ageHint = data['yas']?.toString() ?? '';
        genderHint = data['cinsiyet'] ?? '';
        selectedGender = (genderHint?.isNotEmpty ?? false) ? genderHint : null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Kullanıcı bilgileri alınamadı. Kod: ${response.statusCode}")),
      );
    }
  }

  void update() async {
    var name = nameControllers.text.trim();
    var surname = surnameControllers.text.trim();
    var username = usernameControllers.text.trim();
    var age = ageControllers.text.trim();
    var password = passwordControllers.text;
    var confirmPassword = confirmPasswordControllers.text;
    var gender = selectedGender ?? "";

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Şifre ve şifre tekrarı aynı olmalı!')),
      );
      return;
    }

    var url = Uri.parse("http://10.0.2.2:5001/api/Kullanici/guncelle");
    var body = {
      "id": global.currentUserId,
      "kullaniciadi": username.isEmpty ? usernameHint : username,
      "isim": name.isEmpty ? nameHint : name,
      "soyisim": surname.isEmpty ? surnameHint : surname,
      "yas": age.isEmpty ? int.parse(ageHint ?? '0') : int.parse(age),
      "cinsiyet": gender,
    };

    // Eğer şifre girilmişse body'ye ekle
    if (password.isNotEmpty) {
      body["Sifre"] = password;
    }

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bilgileriniz Güncellendi')),
      );
      Navigator.pop(context, {
        'username': username.isEmpty ? usernameHint : username,
        'password': password,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Güncelleme başarısız. Kod: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        title: Text(
          'Bilgilerini Güncelle',
          style: TextStyle(color: TC),
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
                  hintText: nameHint,
                  labelText: "İsim",
                  labelStyle: TextStyle(color: TC),
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
                  hintText: surnameHint,
                  labelText: "Soyisim",
                  labelStyle: TextStyle(color: TC),
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
                  hintText: usernameHint,
                  labelText: "Kullanıcı Adı",
                  labelStyle: TextStyle(color: TC),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: ageControllers,
                decoration: InputDecoration(
                  hintText: ageHint,
                  labelText: "Yaş",
                  labelStyle: TextStyle(color: TC),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(
                  labelText: "Cinsiyet",
                  labelStyle: TextStyle(color: TC),
                  border: OutlineInputBorder(),
                ),
                items: ['Kadın', 'Erkek', 'Atak Helikopteri', 'Opsiyonel']
                    .map((gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
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
                  labelStyle: TextStyle(color: TC),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: confirmPasswordControllers,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifre Tekrar',
                  labelStyle: TextStyle(color: TC),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: update,
                style: ElevatedButton.styleFrom(
                  backgroundColor: BC,
                ),
                child: Text(
                  'Bilgileri Güncelle',
                  style: TextStyle(color: TC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

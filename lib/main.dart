import 'package:flutter/material.dart';
import 'package:loginkit/ui/login/login.dart';
import 'package:loginkit/ui/success/success.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  var token = checkToken();
    return MaterialApp(
      title: 'Wanna Be a Star',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins'
      ),
      debugShowCheckedModeBanner: false,
      home: token != null ? Login() : SuccessScreen(),
    );
  }

  static Future checkToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.remove('token');
    return sharedPreferences.getString('token') == null ? null : true;
  }
}
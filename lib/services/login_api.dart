import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi{

  static var url = "http://192.168.1.67/api/";
  static var user;
  static var statusCode;
  static var body;
  static var apiUrl;

  static Future<bool> login(String email, String password) async {
    var endpoint = 'login';
    var apiUrl = url + endpoint;

    var response = await http.post(apiUrl, body: {'email' : email, 'password': password});

    Map _responseBody = json.decode(response.body);

    if(response.statusCode == 201){
      // user = User.fromJson(_responseBody);
      user = _responseBody;
      print(_responseBody['user']['roles'][0]['name']);
      setLoginSession(user);
      return true;
    }else{
      user = null;
      return false;
    }
  }


  static Future<bool> register(String name, String email, String password, String confirmPassword, String role) async {
    var endpoint = 'register';
    apiUrl = url + endpoint;

    var data = {
      'name' : name,
      'email' : email,
      'role' : role,
      'password': password,
      'password_confirmation': confirmPassword
    };
    print("data");
    print(json.encode(data));
    print("-----------");


    var response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode(data)
    ).then((http.Response response) {
      statusCode = response.statusCode;
      body = response.body;
    });

    Map _responseBody = json.decode(body);
    print(_responseBody);
    if(statusCode == 201){
      user = _responseBody;
      setLoginSession(user);
      return true;
    }else{
      user = null;
      return false;
    }
  }

  static Future<bool> logout() async {
    var endpoint = 'logout';
    apiUrl = url + endpoint;
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    final response = await http.post(apiUrl, headers: {
      'Authorization': 'Bearer $token',
    }).then((http.Response response) {
      statusCode = response.statusCode;
      body = response.body;
    });

    if(statusCode == 201){
      unsetLoginSession();
      return true;
    }else{
      return false;
    }
  }

  static Future setLoginSession(user) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', user['user']['email']);
    sharedPreferences.setString('name', user['user']['name']);
    sharedPreferences.setString('role', user['user']['roles'][0]['name']);
    sharedPreferences.setString('token', user['token']);
  }

  static Future unsetLoginSession() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('email');
    sharedPreferences.remove('name');
    sharedPreferences.remove('role');
    sharedPreferences.remove('token');
  }

}
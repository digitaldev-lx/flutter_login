import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
import 'package:loginkit/services/user.dart';

class LoginApi{

  static var url = "http://192.168.1.67/api/";

  static Future<User> login(String email, String password) async {
    var endpoint = 'login';
    var user;
    var apiUrl = url + endpoint;

    var response = await http.post(apiUrl, body: {'email' : email, 'password': password});

    Map _responseBody = json.decode(response.body);

    if(response.statusCode == 201){
      user = User.fromJson(_responseBody);
    }else{
      user = null;
    }
    return user;
  }


  static Future<User> register(String name, String email, String password, String confirmPassword, String role) async {
    var endpoint = 'register';
    var user;
    var statusCode;
    var body;
    var apiUrl = url + endpoint;

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
      body = response.body;
    });

    Map _responseBody = json.decode(body);

    print("Response Body");
    print(_responseBody);


    if(statusCode == 201){
      user = User.fromJson(_responseBody);
    }else{
      user = null;
    }
    return user;

  }


}
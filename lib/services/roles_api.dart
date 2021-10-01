import 'dart:convert';
import 'package:http/http.dart' as http;

class RolesApi{

  static var url = "http://192.168.1.67/api/";

  static Future<String> fetchRoles() async {
    var endpoint = 'roles';
    var apiUrl = url + endpoint;
    final response = await http.get(apiUrl);
    final responseJson = json.decode(response.body);
    var finalResponse = json.encode(responseJson);

    if (response.statusCode == 200) {

      return finalResponse;
    } else {
      throw Exception('Failed to load roles');
    }
  }
}
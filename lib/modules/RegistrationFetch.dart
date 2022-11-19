import 'dart:convert';

import 'package:flutter_proj/data/JSONData.dart';
import 'package:http/http.dart' as http;

Future<dynamic> registrationFetch(
    String login, String email, String password, String password2) async {
  var response = await http.post(
      Uri.parse('http://localhost:8080/Library/api/registration/'),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': login,
        'password': password,
        'password2': password2
      }));

  if (response.statusCode == 200) {
    var data = response.body;

    final registrationData = RegistrationData.fromJson(jsonDecode(data));

    return registrationData.msg;
  } else {
    print(response.statusCode);
    throw Exception(response.statusCode);
  }
}

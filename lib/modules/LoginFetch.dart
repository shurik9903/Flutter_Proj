import 'dart:convert';

import 'package:flutter_proj/data/JSONData.dart';
import 'package:http/http.dart' as http;

Future<dynamic> loginFetch(String login, String password) async {
  var response = await http.get(
      Uri.parse('http://localhost:8080/Library/api/login/$login/$password'),
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "Token": "null"
      });

  if (response.statusCode == 200) {
    var data = response.body;

    final loginData = LoginData.fromJson(jsonDecode(data));

    if (loginData.msg != null) throw Exception(loginData.msg);

    return "ok";
  } else {
    print(response.statusCode);
    throw Exception(response.statusCode);
  }
}

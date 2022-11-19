import 'dart:convert';
import 'package:flutter_proj/data/UserData.dart';
import 'package:http/http.dart' as http;

import '../data/DataDescript.dart';

Future<dynamic> descriptionFetch(DataDescript dataDescript) async {
  var userData = UserData_Singleton();

  var response =
      await http.post(Uri.parse('http://localhost:8080/Library/api/descript/'),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "application/json",
            "Token": userData.token,
            "UserID": userData.id
          },
          body: dataDescript.toJson());

  if (response.statusCode == 200) {
    var data = response.body;

    print(data);

    return '';
  } else {
    print(response.statusCode);
    throw Exception(response.statusCode);
  }
}

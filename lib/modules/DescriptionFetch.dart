import 'dart:convert';
import 'package:flutter_proj/data/UserData.dart';
import 'package:http/http.dart' as http;

import '../data/JSONData.dart';

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

    return;
  } else {
    print(response.statusCode);
    throw Exception(response.statusCode);
  }
}

Future<dynamic> getDescriptFetch(String titleID) async {
  var userData = UserData_Singleton();

  if (titleID.isEmpty) return;

  var response = await http.get(
    Uri.parse('http://localhost:8080/Library/api/descript/'),
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
      "Token": userData.token,
      "UserID": userData.id,
      "TitleID": titleID
    },
  );

  if (response.statusCode == 200) {
    var data = response.body;

    List js = jsonDecode(jsonDecode(data)["Description"]) as List;
    List<DataDescript> listDesc =
        js.map((e) => DataDescript.fromJson(e)).toList();

    return listDesc;
  } else {
    print(response.statusCode);
    throw Exception(response.statusCode);
  }
}

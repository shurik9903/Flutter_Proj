import 'dart:convert';
import 'package:flutter_proj/data/UserData.dart';
import 'package:http/http.dart' as http;

import '../data/JSONData.dart';

Future<dynamic> putDescriptionFetch(DataDescript dataDescript) async {
  var userData = UserData_Singleton();
  dataDescript.userid = userData.id;

  var response =
      await http.put(Uri.parse('http://localhost:8080/Library/api/descript/'),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "application/json",
            "Token": userData.token,
          },
          body: dataDescript.toJson());

  if (response.statusCode == 200) {
    var data = response.body;

    if (jsonDecode(data)["Msg"] != null) {
      throw Exception('${jsonDecode(data)["Msg"]}');
    }

    return "Описание успешно изменено";
  } else {
    print(response.statusCode);
    throw Exception(response.statusCode);
  }
}

Future<dynamic> addDescriptionFetch(DataDescript dataDescript) async {
  var userData = UserData_Singleton();
  dataDescript.userid = userData.id;

  var response =
      await http.post(Uri.parse('http://localhost:8080/Library/api/descript/'),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "application/json",
            "Token": userData.token,
          },
          body: dataDescript.toJson());

  if (response.statusCode == 200) {
    var data = response.body;

    if (jsonDecode(data)["Description msg"] != null ||
        jsonDecode(data)["Title msg"] != null) {
      throw Exception(
          '${jsonDecode(data)["Description msg"] ?? ''}. ${jsonDecode(data)["Title msg"] ?? ''}');
    }

    return "Описание успешно добавлено";
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

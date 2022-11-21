import 'dart:convert';

import 'package:flutter_proj/data/JSONData.dart';

import '../data/UserData.dart';
import 'package:http/http.dart' as http;

// Future<dynamic> titleFetch(String name) async {
//   var userData = UserData_Singleton();

//   var response =
//       await http.post(Uri.parse('http://localhost:8080/Library/api/descript/'),
//           headers: {
//             "Content-Type": "application/json; charset=UTF-8",
//             "Accept": "application/json",
//             "Token": userData.token,
//             "UserID": userData.id
//           },
//           body: dataDescript.toJson());

//   if (response.statusCode == 200) {
//     var data = response.body;

//     print(data);

//     return '';
//   } else {
//     print(response.statusCode);
//     throw Exception(response.statusCode);
//   }
// }

Future<dynamic> getTitleFetch(String titleName) async {
  var userData = UserData_Singleton();

  var response = await http.get(
    Uri.parse('http://localhost:8080/Library/api/title/'),
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
      "Token": userData.token,
      "UserID": userData.id,
      "TitleName": titleName
    },
  );

  if (response.statusCode == 200) {
    var data = response.body;
    print(data);

    final titleData = TitleData.fromJson(jsonDecode(data));

    if (titleData.msg != null) throw Exception(titleData.msg);

    return titleData;
  } else {
    print(response.body);
    throw Exception(response.statusCode);
  }
}

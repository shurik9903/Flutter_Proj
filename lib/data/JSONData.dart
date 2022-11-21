import 'dart:convert';

import 'package:flutter/material.dart';

class LoginData {
  LoginData({this.msg, this.userID, this.userLogin, this.token});

  final String? msg;
  final String? userID;
  final String? userLogin;
  final String? token;

  factory LoginData.fromJson(Map<String, dynamic> data) {
    final msg = data['Msg'] as String?;
    final userID = data['UserID'] as String?;
    final userLogin = data['userLogin'] as String?;
    final token = data['Token'] as String?;
    return LoginData(
        msg: msg, userID: userID, userLogin: userLogin, token: token);
  }
}

class TitleData {
  TitleData({this.msg, this.title, this.titleID});

  final String? titleID;
  final String? title;
  final String? msg;

  factory TitleData.fromJson(Map<String, dynamic> data) {
    final msg = data['Msg'] as String?;
    final title = data['Title'] as String?;
    final titleID = data['TitleID'] as String?;
    return TitleData(msg: msg, title: title, titleID: titleID);
  }
}

class DataDescript {
  String? id = "";
  String? name = "";
  List<String>? otherName = [];
  List<Image>? images = [];
  String? text = "";
  Color? color = const Color.fromARGB(255, 0, 0, 0);
  String? title = "";
  String? msg = "";

  DataDescript.empty();

  DataDescript(
      {this.id,
      this.name,
      this.otherName,
      this.images,
      this.text,
      this.color,
      this.title,
      this.msg});

  factory DataDescript.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String?;
    final name = data['name'] as String?;
    final otherName =
        (data['otherName'] as List).map((e) => e.toString()).toList();
    final images = (data['images'] as List).map((e) => null).toList();
    final text = data['text'] as String?;
    final color = Color(int.parse(data['color']));
    final title = data['title'] as String?;
    final msg = data['Msg'] as String?;

    return DataDescript(
        id: id,
        name: name,
        otherName: otherName,
        images: null,
        text: text,
        color: color,
        title: title,
        msg: msg);
  }

  String toJson() {
    print(color?.value.toString() ?? "");
    return jsonEncode(<String, String>{
      "id": id ?? '',
      "name": name ?? '',
      "otherName": jsonEncode(otherName),
      "images": jsonEncode(images),
      "text": text ?? '',
      "color": color?.value.toString() ?? "",
      "title": title ?? ''
    });
  }
}

class RegistrationData {
  RegistrationData({this.msg});

  final String? msg;

  factory RegistrationData.fromJson(Map<String, dynamic> data) {
    final msg = data['Msg'] as String?;

    return RegistrationData(msg: msg);
  }
}

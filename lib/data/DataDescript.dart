import 'dart:convert';

import 'package:flutter/material.dart';

class DataDescript {
  String? name = "";
  List<String>? otherName = [];
  List<Image>? images = [];
  String? text = "";
  Color? color = const Color.fromARGB(255, 0, 0, 0);
  String? title = "";

  DataDescript.empty();

  DataDescript(
      {this.name,
      this.otherName,
      this.images,
      this.text,
      this.color,
      this.title});

  factory DataDescript.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String?;
    final otherName = data['otherName'] as List<String>?;
    final images = data['images'] as List<Image>?;
    final text = data['text'] as String?;
    final color = data['text'] as Color?;
    final title = data['title'] as String?;

    return DataDescript(
        name: name,
        otherName: otherName,
        images: images,
        text: text,
        color: color,
        title: title);
  }

  String toJson() {
    return jsonEncode(<String, String>{
      "name": name ?? '',
      "otherName": jsonEncode(otherName),
      "images": jsonEncode(images),
      "text": text ?? '',
      "color": color.toString(),
      "title": title ?? ''
    });
  }
}

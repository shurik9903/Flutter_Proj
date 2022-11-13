import 'package:flutter/material.dart';

class DataText {
  String _name = "";
  List<String> _otherName = [];
  Color _color = const Color.fromARGB(255, 0, 0, 0);

  DataText.empty();

  DataText(String name, List<String> otherName, Color color)
      : _name = name,
        _otherName = otherName,
        _color = color;

  set name(String name) => _name;
  String get name => _name;

  set addOtherName(String otherName) {
    _otherName.add(otherName);
  }

  List<String> get otherName => _otherName;

  set color(Color color) => _color;
  Color get color => _color;
}

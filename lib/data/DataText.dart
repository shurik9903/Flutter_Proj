import 'package:flutter/material.dart';

class DataText {
  String _descriptid = "";
  String _name = "";
  List<String> _otherName = [];
  Color _color = const Color.fromARGB(255, 0, 0, 0);

  DataText.empty();

  DataText(String descriptid, String name, List<String> otherName, Color color)
      : _descriptid = descriptid,
        _name = name,
        _otherName = otherName,
        _color = color;

  set name(String name) => _name = name;
  String get name => _name;

  set descriptid(String descriptid) => _descriptid = descriptid;
  String get descriptid => _descriptid;

  set addOtherName(String otherName) {
    _otherName.add(otherName);
  }

  List<String> get otherName => _otherName;

  set color(Color color) => _color = color;
  Color get color => _color;
}

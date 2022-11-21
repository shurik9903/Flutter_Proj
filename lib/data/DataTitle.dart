import 'package:flutter/material.dart';
import 'package:flutter_proj/data/JSONData.dart';

class DataTitle extends ChangeNotifier {
  String _id = '';
  String _title = '';
  List<DataDescript> _descript = [];

  set id(String id) {
    _id = id;
    notifyListeners();
  }

  String get id => _id;

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  String get title => _title;

  addDescriptElement(DataDescript descript) {
    _descript.add(descript);
    notifyListeners();
  }

  set descript(List<DataDescript> descript) {
    _descript = descript;
    notifyListeners();
  }

  List<DataDescript> get descript => _descript;
}

// class TitleData_Singleton extends TitleDataBase {
//   static final TitleData_Singleton _singleton =
//       TitleData_Singleton._constructor();

//   factory TitleData_Singleton() {
//     return _singleton;
//   }

//   TitleData_Singleton._constructor();
// }

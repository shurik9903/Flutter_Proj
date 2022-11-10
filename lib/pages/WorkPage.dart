import 'package:flutter/material.dart';
import 'package:flutter_proj/pages/WEBDialog.dart';
import 'package:provider/provider.dart';

import '../theme/AppThemeDefault.dart';

class DataText {
  String _name = "";
  List<String> _otherName = [];
  Color _color = Color.fromARGB(255, 0, 0, 0);

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

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  AppThemeDefault appTheme(BuildContext context) =>
      Theme.of(context).appDefault();

  final SelectText _selectText = SelectText();
  List<TextSpan> _parseText = [];
  List<String> person = [''];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _selectText,
          ),
        ],
        builder: (context, child) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    color: appTheme(context).mColor1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            margin: const EdgeInsets.all(5),
                            color: appTheme(context).mColor3,
                            // child: SingleChildScrollView(
                            //   scrollDirection: Axis.vertical,
                            // child: Text(
                            //   context.watch<SelectText>().Text,
                            // ),

                            // ),
                            child:
                                RichText(text: TextSpan(children: _parseText)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await showDialogWindow(context).then((value) {
                        context.read<SelectText>().Text = value as String;
                        setState(() {
                          _parseText = parsingText(value);
                        });
                      });
                    },
                    icon: const Icon(Icons.colorize)),
              ],
            ),
          );
        },
      ),
    );
  }
}

List<TextSpan> parsingText(String text) {
  String myText =
      "- Дорогой Лейлин дулин, это семейная реликвия, дар Лейлин дулин Мага. Когда мой дед помог раненному Магу, тот взамен дал ему это кольцо и сказал, что если кто-то будет Лейлин дулин иметь дар к магии, пусть оденет его, и оно ему поможет вступить в любую гильдию безо всяких усилий. Я дарую его тебе в надежде, что ты станешь гордостью нашей семьи.";

  List<Map<String, dynamic>> persons = [
    {
      'other_name': ['Мага', 'other'],
      'person_name': 'Лейлин дулин'
    }
  ];

  List<dynamic> res = [myText];

  persons.forEach((person) {
    [...person['other_name'], person['person_name']].forEach((names) {
      print(names);

      RegExp reg = RegExp('');
      String end_reg = '?(ер|ем|ой|ом|ёй|ью|[ыейуаиляью]|)';

      // print(names);

      (names as String).split(' ').asMap().forEach((index, name) {
        if (index == 0) {
          reg = RegExp(name + end_reg);
        } else {
          reg = RegExp('${reg.pattern}(\\s$name$end_reg|)');
        }
      });

      // text.replaceAllMapped(reg!, (match) {
      //   print(match[1]);
      //   return '';
      // });

      // print(reg);
      // res = (myText.split(reg));
      // res.forEach((element) {
      //   print(element);
      // });

      // print(reg);
      List<dynamic> res2 = res;
      res.asMap().forEach((index, element) {
        print(element);

        if (element is String) {
          List<dynamic> split = [];

          // print(element);

          print(reg);

          element.splitMapJoin(
            reg,
            onMatch: (m) {
              split.add(
                DataText(
                  '${m[0]}',
                  [],
                  Color.fromARGB(255, 255, 0, 0),
                ),
              );
              // print('test1 ${m[0]}');
              return '${m[0]}';
            },
            onNonMatch: (n) {
              split.add('${n}');
              // print('test2 ${n.toString()}');
              return '$n';
            },
          );

          // print(split);

          // print(index);
          // print(res.length);

          // print('do $res');
          // print('test1 ${res.getRange(0, index)}');
          // print('test2 ${res.getRange(index, res.length)}');

          // res = [
          //   ...res.getRange(0, index),
          //   ...split,
          //   ...res.getRange(index + 1, res.length)
          // ];

          // print('pos $res');

          res2[index] = split;
        }
      });
      res = [];
      res2.asMap().forEach((index, value) {
        if (value is List<dynamic>) {
          res.addAll(value);
        } else {
          res.add(value);
        }
      });
      print(res);
      // myText = myText.splitMapJoin(
      //   reg,
      //   onMatch: (m) {
      //     res.add(DataText('${m[0]}', [], Color.fromARGB(255, 255, 0, 0)));
      //     // print('${m[0]}');
      //     return '';
      //   },
      //   onNonMatch: (n) {
      //     res.add('${n.toString()}');
      //     // print('${n.toString()}');
      //     return '$n';
      //   },
      // );
    });
  });

  List<TextSpan> textSpan = [];

  res.forEach((element) {
    if (element is DataText) {
      textSpan.add(TextSpan(
        text: element._name,
        style: TextStyle(color: element._color),
      ));
    }

    if (element is String) {
      textSpan.add(TextSpan(
        text: element,
      ));
    }
  });

  return textSpan;
}

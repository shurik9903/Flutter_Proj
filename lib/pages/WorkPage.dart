import 'package:flutter/material.dart';
import 'package:flutter_proj/data/DataTitle.dart';
import 'package:flutter_proj/data/JSONData.dart';
import 'package:flutter_proj/data/UserData.dart';
import 'package:flutter_proj/main.dart';
import 'package:flutter_proj/modules/TitleFetch.dart';
import 'package:flutter_proj/widgets/SidePanel.dart';
import 'package:flutter_proj/widgets/WEBDialog.dart';
import 'package:provider/provider.dart';

import '../data/DataText.dart';
import '../theme/AppThemeDefault.dart';
import '../theme/ThemeFactory.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  AppThemeDefault appTheme(BuildContext context) =>
      Theme.of(context).appDefault();

  final SelectText _selectText = SelectText();
  final DataTitle _dataTitle = DataTitle();
  List<TextSpan> _parseText = [];
  List<String> person = [''];

  @override
  void initState() {
    super.initState();
    () async {
      await getTitleFetch("Test").then((value) {
        setState(() {
          if (value is TitleData) {
            _dataTitle.id = value.titleID ?? "";
            _dataTitle.title = value.title ?? "";
          }
        });
      }).catchError((error) {
        print(error);
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _selectText,
          ),
          ChangeNotifierProvider(
            create: (context) => _dataTitle,
          ),
        ],
        builder: (context, child) {
          return Column(
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
                        child: Stack(
                          children: [
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              color: appTheme(context).mColor3,
                              child: RichText(
                                  text: TextSpan(children: _parseText)),
                            ),
                            const SidePanel(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                  onPressed: () {
                    context.read<SelectTheme>().change();
                  },
                  icon: const Icon(Icons.palette),
                ),
                Text(context.watch<DataTitle>().title),
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
              ]),
            ],
          );
        },
      ),
    );
  }
}

List<TextSpan> parsingText(String text) {
  String myText =
      "- Дорогой Лейлин дулин, это семейная реликвия, дар Лейлин дулин Мага. Когда мой дед помог раненному Магу, тот взамен дал ему это кольцо и сказал, что если кто-то будет Лейлин дулин иметь дар к магии, пусть оденет его, и оно ему поможет вступить в любую гильдию безо всяких усилий. Я дарую его тебе в надежде, что ты станешь гордостью нашей семьи.";

  List<DataText> persons = [
    DataText(
        'Лейлин', ['Мага', 'other'], const Color.fromARGB(2500, 255, 0, 0)),
    DataText('реликвия', [], const Color.fromARGB(196, 47, 61, 255)),
  ];

  List<dynamic> res = [myText];

  for (var person in persons) {
    for (var names in [...person.otherName, person.name]) {
      RegExp reg = RegExp('');
      String endReg = '?(ер|ем|ой|ом|ёй|ью|[ыейуаиляью]|)';

      names.split(' ').asMap().forEach((index, name) {
        if (index == 0) {
          reg = RegExp(name + endReg);
        } else {
          reg = RegExp('${reg.pattern}(\\s$name$endReg|)');
        }
      });

      List<dynamic> resPeriod = [];
      res.asMap().forEach((index, element) {
        if (element is String) {
          List<dynamic> split = [];

          element.splitMapJoin(
            reg,
            onMatch: (m) {
              split.add(person);
              return '';
            },
            onNonMatch: (n) {
              split.add(n);
              return '';
            },
          );

          resPeriod.addAll(split);
        } else {
          resPeriod.add(element);
        }
      });

      res = resPeriod;
    }
  }

  List<TextSpan> textSpan = [];

  for (var element in res) {
    if (element is DataText) {
      textSpan.add(TextSpan(
        text: element.name,
        style: TextStyle(color: element.color),
      ));
    }

    if (element is String) {
      textSpan.add(TextSpan(
        text: element,
      ));
    }
  }

  return textSpan;
}

import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/data/DataTitle.dart';
import 'package:flutter_proj/data/JSONData.dart';
import 'package:flutter_proj/data/UserData.dart';
import 'package:flutter_proj/main.dart';
import 'package:flutter_proj/modules/DescriptionFetch.dart';
import 'package:flutter_proj/modules/TitleFetch.dart';
import 'package:flutter_proj/widgets/DescriptCreate.dart';
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

  // final SelectText _selectText = SelectText();
  final SelectView _viewWidget = SelectView();
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
            create: (context) => _viewWidget,
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
                            SidePanel(),
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
                        // context.read<SelectText>().Text = value as String;

                        getDescriptFetch(context.read<DataTitle>().id)
                            .then((desc) {
                          if (desc is List<DataDescript>) {
                            List<DataText> dataText = desc.map((e) {
                              return DataText(
                                  e.id ?? "",
                                  e.name ?? "",
                                  e.otherName ?? [],
                                  e.color ??
                                      Color.fromARGB(255, 255, 255, 255));
                            }).toList();

                            setState(() {
                              _parseText = parsingText(
                                value as String,
                                dataText = dataText,
                                (String descriptid) async {
                                  String? titleid =
                                      context.read<DataTitle>().id;
                                  await getDescriptFetch(titleid).then((value) {
                                    if (value is List<DataDescript>) {
                                      for (DataDescript desc in value) {
                                        if (desc.id == descriptid) {
                                          context.read<SelectView>().view =
                                              DescriptCreate(
                                            id: desc.id,
                                            name: desc.name,
                                            otherName: desc.otherName,
                                            images: desc.images,
                                            pickerColor: desc.color,
                                            text: desc.text,
                                            action: true,
                                          );
                                          break;
                                        }
                                      }
                                    }
                                  }).catchError((error) {
                                    print(error);
                                  });
                                },
                              );
                            });
                          }
                        }).catchError((error) {
                          print(error);
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

List<TextSpan> parsingText(
    String text, List<DataText> persons, Function tapCallback) {
  List<dynamic> res = [text];

  for (var person in persons) {
    for (var name in [...person.otherName, person.name]) {
      RegExp reg = RegExp('');
      String endReg = '?(ер|ем|ой|ом|ёй|ью|[ыейуаиляью]|)';

      name.split(' ').asMap().forEach((index, name) {
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
              split.add(DataText(person.descriptid, name, [], person.color));
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
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            tapCallback(element.descriptid);
          },
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

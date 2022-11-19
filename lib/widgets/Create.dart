import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_proj/data/DataDescript.dart';
import 'package:flutter_proj/modules/DescriptionFetch.dart';

import '../theme/AppThemeDefault.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  Color pickerColor = const Color.fromARGB(255, 255, 255, 255);

  String name = '';
  List<String> otherName = [];
  List<Image> images = [];
  String text = '';
  String msg = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 55,
            decoration: BoxDecoration(
              color: appTheme(context).mColor1.withOpacity(0.4),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: appTheme(context).mColor3)),
                    ),
                    child: const Text("Имя")),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      textAlignVertical: const TextAlignVertical(y: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 55,
            decoration: BoxDecoration(
              color: appTheme(context).mColor1.withOpacity(0.4),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: appTheme(context).mColor3)),
                    ),
                    child: const Text("Псевдоним")),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          otherName = value.split(',');
                        });
                      },
                      textAlignVertical: const TextAlignVertical(y: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: appTheme(context).mColor1.withOpacity(0.4),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: appTheme(context).mColor3)),
                    ),
                    child: const Text("Изображения"),
                  ),
                  Column(
                    children: [],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {},
                      child: Text(
                          style: TextStyle(color: pickerColor),
                          "Загрузить изображения"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: appTheme(context).mColor1.withOpacity(0.4),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: appTheme(context).mColor3)),
                    ),
                    child: const Text("Описание"),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            text = value;
                          });
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 35,
            decoration: BoxDecoration(
              color: appTheme(context).mColor1.withOpacity(0.4),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: TextButton(
              onPressed: () async {
                await showColorDialogWindow(context).then((color) {
                  setState(() {
                    pickerColor = color as Color;
                  });
                });
              },
              child: Text(style: TextStyle(color: pickerColor), "Задать цвет"),
            ),
          ),
          Text(''),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                appTheme(context).mColor1.withOpacity(0.3),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            onPressed: () async {
              DataDescript data = DataDescript(
                  name: name,
                  otherName: otherName,
                  images: images,
                  color: pickerColor,
                  text: text,
                  title: "Test");

              descriptionFetch(data).then((value) {
                setState(() {
                  msg = value;
                });
              }).catchError((error) {
                msg = error.toString();
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

Future<void> showColorDialogWindow(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return const ColorDialog();
    },
  );
}

class ColorDialog extends StatefulWidget {
  const ColorDialog({super.key});

  @override
  State<ColorDialog> createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  Color pickerColor = const Color.fromARGB(255, 255, 255, 255);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
      children: [
        ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context, pickerColor);
            },
            child: const Text("OK"))
      ],
    ));
  }
}

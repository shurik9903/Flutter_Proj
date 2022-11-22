import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_proj/modules/DescriptionFetch.dart';
import 'package:provider/provider.dart';

import '../data/DataTitle.dart';
import '../data/JSONData.dart';
import '../theme/AppThemeDefault.dart';

class DescriptCreate extends StatefulWidget {
  String? id;
  String? name;
  List<String>? otherName;
  List<Image>? images;
  String? text;
  Color? pickerColor;
  bool? action;

  DescriptCreate(
      {super.key,
      this.id,
      this.name,
      this.otherName,
      this.images,
      this.text,
      this.pickerColor,
      this.action});

  @override
  State<DescriptCreate> createState() => _DescriptState();
}

class _DescriptState extends State<DescriptCreate> {
  late String id;
  late String name;
  late List<String> otherName;
  late List<Image> images;
  late String text;
  late Color pickerColor;
  late bool action;
  String msg = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      id = widget.id ?? "";
      name = widget.name ?? "";
      otherName = widget.otherName ?? [];
      images = widget.images ?? [];
      text = widget.text ?? "";
      pickerColor =
          widget.pickerColor ?? const Color.fromARGB(255, 255, 255, 255);
      action = widget.action ?? false;
    });
  }

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
                    child: const Text(
                      "Имя",
                    )),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: TextFormField(
                      style: TextStyle(color: pickerColor),
                      initialValue: name,
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
                    child: TextFormField(
                      initialValue: otherName.join(","),
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
                    children: images,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        print(pickerColor);
                      },
                      child: const Text("Загрузить изображения"),
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
                      child: TextFormField(
                        initialValue: text,
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
                    print(color as Color);
                    pickerColor = color as Color;
                  });
                });
              },
              child: Text(style: TextStyle(color: pickerColor), "Задать цвет"),
            ),
          ),
          Text(msg),
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
                id: id,
                name: name,
                otherName: otherName,
                images: images,
                color: pickerColor,
                text: text,
                title: "Test",
                titleid: context.read<DataTitle>().id,
              );

              if (!action) {
                await addDescriptionFetch(data).then((value) {
                  setState(() {
                    msg = value;
                  });
                }).catchError((error) {
                  setState(() {
                    msg = error.toString();
                  });
                });
              }

              if (action) {
                await putDescriptionFetch(data).then((value) {
                  setState(() {
                    msg = value;
                  });
                }).catchError((error) {
                  setState(() {
                    msg = error.toString();
                  });
                });
              }
            },
            child: Text(action ? "Изменить" : "Добавить"),
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

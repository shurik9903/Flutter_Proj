import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../theme/AppThemeDefault.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  Color pickerColor = const Color.fromARGB(255, 255, 255, 255);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          const CreateField(text: "Имя:"),
          const CreateField(text: "Псевдонимы:"),
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
                children: const [
                  Text("Описание"),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: TextField(
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
            onPressed: () {},
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

class CreateField extends StatefulWidget {
  final String text;
  const CreateField({super.key, required this.text});

  @override
  State<CreateField> createState() => _CreateFieldState();
}

class _CreateFieldState extends State<CreateField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 35,
      decoration: BoxDecoration(
        color: appTheme(context).mColor1.withOpacity(0.4),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(left: 5), child: Text(widget.text)),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: const TextField(
                textAlignVertical: TextAlignVertical(y: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

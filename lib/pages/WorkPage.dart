import 'package:flutter/material.dart';
import 'package:flutter_proj/pages/WEBDialog.dart';

import '../theme/AppThemeDefault.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  AppThemeDefault appTheme(BuildContext context) =>
      Theme.of(context).appDefault();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
                        child: const TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  await showDialogWindow(context);
                },
                icon: const Icon(Icons.colorize)),
          ],
        ),
      ),
    );
  }
}

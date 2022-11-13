import 'package:flutter/material.dart';
import 'package:flutter_proj/widgets/Create.dart';

import '../theme/AppThemeDefault.dart';

class SidePanel extends StatefulWidget {
  const SidePanel({super.key});

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  Widget viewWidget = Create();
  bool view = true;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        width: view ? 250 : 20,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                height: 100,
                child: TextButton(
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
                  onPressed: () {
                    setState(() {
                      view = !view;
                    });
                  },
                  child: view ? const Text('>') : const Text('<'),
                ),
              ),
            ),
            Expanded(
              flex: view ? 10 : 0,
              child: Visibility(
                visible: view,
                maintainState: true,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: appTheme(context).mColor1.withOpacity(0.3),
                  height: double.infinity,
                  width: 200,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            color: appTheme(context).mColor4.withOpacity(0.4),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: ListView(
                            clipBehavior: Clip.hardEdge,
                            scrollDirection: Axis.horizontal,
                            children: [
                              IconButton(
                                alignment: Alignment.center,
                                onPressed: () {},
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 20,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            color: appTheme(context).mColor4.withOpacity(0.4),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: viewWidget,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_proj/theme/AppThemeDefault.dart';
import 'package:provider/provider.dart';

import 'dart:html';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

import 'package:webviewx/webviewx.dart';

class SelectText extends ChangeNotifier {
  String _text = "";

  set Text(String text) {
    _text = text;
    notifyListeners();
  }

  String get Text => _text;
}

class SelectUrl extends ChangeNotifier {
  String _url = "";

  set Url(String url) {
    _url = url;
    notifyListeners();
  }

  String get Url => _url;
}

Future<void> showDialogWindow(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return URLDialog();
    },
  );
}

class URLDialog extends StatefulWidget {
  const URLDialog({super.key});

  @override
  State<URLDialog> createState() => _URLDialogState();
}

class _URLDialogState extends State<URLDialog> {
  String? urlInput = "";
  final SelectText _selectText = SelectText();
  final SelectUrl _selectUrl = SelectUrl();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _selectText,
          ),
          ChangeNotifierProvider(
            create: (context) => _selectUrl,
          )
        ],
        builder: (context, child) {
          return Stack(
            // child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Text("Просмотр сайта"),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: const Text(
                            "URL: ",
                            maxLines: null,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  urlInput = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: IconButton(
                            onPressed: () {
                              context.read<SelectUrl>().Url = urlInput ?? "";
                            },
                            icon: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        color: appTheme(context).mColor1,
                        height: double.infinity,
                        width: double.infinity,
                        child: const WebView(),
                      ),
                    ),
                    Container(
                      color: appTheme(context).mColor2,
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      margin: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(context.watch<SelectText>().Text),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, _selectText.Text);
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  WebViewXController? webviewController;

  @override
  Widget build(BuildContext context) {
    // () async {
    //   var response = await http.Client()
    //       .get(Uri.parse('https://ranobelib.me/wujie-shushi-novel/v1/c1'));
    //   if (response.statusCode == 200) {
    //     String htmlToParse = response.body;
    //     print(htmlToParse);
    //     print('not error');
    //   } else {
    //     print("error");
    //   }
    // };

    String url = context.watch<SelectUrl>().Url;
    webviewController?.loadContent(url, SourceType.urlBypass);

    return WebViewAware(
      child: SizedBox(
        child: WebViewX(
          // initialContent: 'https://ranobelib.me/wujie-shushi-novel/v1/c1',
          initialContent: 'https://flutter.dev',
          initialSourceType: SourceType.urlBypass,
          onWebViewCreated: (controller) async {
            webviewController = controller;
          },
          javascriptMode: JavascriptMode.unrestricted,
          dartCallBacks: {
            DartCallback(
              name: 'SetTextDart',
              callBack: (text) {
                context.read<SelectText>().Text = text;
              },
            )
          },
          jsContent: const {
            EmbeddedJsContent(
              js: 'var select = true;' +
                  'var element = null;' +
                  'document.addEventListener(\'mouseover\', function(e) {if (select) { e.target.style.border = "thick solid #FF0000";}});' +
                  'document.addEventListener(\'mouseout\', function(e) {if (select) { e.target.style.border = null;}});' +
                  'document.addEventListener(\'click\', function(e) {if (select) { e.target.style.border = "thick solid #00FF00"; select = false; element = e.target; SetTextDart(element.innerText);}' +
                  ' else {select = true; element.style.border = null; element = null; SetTextDart("");}});',
            ),
          },
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          onPageFinished: (src) {
            // final res = await webviewController.evalRawJavascript(
            //     "window.document.getElementsByTagName('html')[0].innerHTML;");

            // print(res);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_proj/theme/AppThemeDefault.dart';

import 'dart:html';
import 'dart:ui' as ui;

import 'package:webviewx/webviewx.dart';

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
  String? urlInput = "", url = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
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
                      child: const Text("URL: "),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              urlInput = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    color: appTheme(context).mColor1,
                    height: double.infinity,
                    width: double.infinity,
                    child: WebView(),
                    // child: IFrameScreen(
                    //   url: url ?? "",
                    // ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (urlInput != null) {
                      setState(() {
                        url = urlInput;
                      });
                    }
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class IFrameScreen extends StatefulWidget {
//   final String url;
//   const IFrameScreen({super.key, required this.url});

//   @override
//   State<IFrameScreen> createState() => _IFrameScreenState();
// }

// class _IFrameScreenState extends State<IFrameScreen> {
//   final IFrameElement _iFrameElement = IFrameElement();

//   @override
//   void initState() {
//     _iFrameElement.style.height = '100%';
//     _iFrameElement.style.width = '100%';
//     _iFrameElement.src =
//         "https://ranobelib.me/wujie-shushi-novel?section=comments";
//     _iFrameElement.id = "HTML_View";
//     _iFrameElement.style.border = 'none';
//     ;

//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       'HTML_IFrame',
//       (int viewId) => _iFrameElement,
//     );

//     super.initState();
//   }

//   final Widget _iframeWidget = HtmlElementView(
//     onPlatformViewCreated: (id) {
//       print(document.getElementById('HTML_View'));
//     },
//     viewType: 'HTML_IFrame',
//     key: UniqueKey(),
//   );

//   @override
//   Widget build(BuildContext context) {

//     // _iFrameElement.src = widget.url;

//     return _iframeWidget;
//   }
// }

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late WebViewXController webviewController;

  String data = "Test";

  @override
  Widget build(BuildContext context) {
    print(data);

    return WebViewAware(
      child: SizedBox(
        child: WebViewX(
          initialContent: 'https://flutter.dev',
          initialSourceType: SourceType.urlBypass,
          onWebViewCreated: (controller) {
            webviewController = controller;
          },
          javascriptMode: JavascriptMode.unrestricted,
          dartCallBacks: {
            DartCallback(
              name: 'SetTextDart',
              callBack: (text) {
                setState(() {
                  data = text;
                });
              },
            )
          },
          jsContent: const {
            EmbeddedJsContent(
              // js: 'var select = true;' +
              //     'var element = null;' +
              //     'document.addEventListener(\'mouseover\', function(e) {if (select) {console.log(e.target); e.target.style.border = "thick solid #FF0000"; console.log(e.target.innerText);}});' +
              //     'document.addEventListener(\'mouseout\', function(e) {if (select) {console.log(e.target); e.target.style.border = null;}});' +
              //     'document.addEventListener(\'click\', function(e) {if (select) {console.log(e.target); e.target.style.border = "thick solid #00FF00"; select = false; element = e.target;}' +
              //     ' else {select = true; element.style.border = null; element = null;}});',
              js: 'var select = true;' +
                  'var element = null;' +
                  'document.addEventListener(\'mouseover\', function(e) {if (select) { e.target.style.border = "thick solid #FF0000";}});' +
                  'document.addEventListener(\'mouseout\', function(e) {if (select) { e.target.style.border = null;}});' +
                  'document.addEventListener(\'click\', function(e) {if (select) { e.target.style.border = "thick solid #00FF00"; select = false; element = e.target; SetTextDart(element.innerText);}' +
                  ' else {select = true; element.style.border = null; element = null;}});',
            ),
          },
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          onPageFinished: (src) async {
            final res = await webviewController.evalRawJavascript(
                "window.document.getElementsByTagName('html')[0].innerHTML;");

            // print(res);
          },
        ),
      ),
    );
  }
}

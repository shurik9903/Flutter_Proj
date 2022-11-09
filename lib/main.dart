import 'package:flutter/material.dart';
import 'modules/RoutePage.dart';
import 'theme/ThemeFactory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  EnumTheme enumTheme = EnumTheme.dark;
  EnumPage enumPage = EnumPage.none;

  @override
  Widget build(BuildContext context) {
    RoutePageFactory pageFactory = RoutePageFactory();
    ThemeFactory themeFactory = ThemeFactory();

    return MaterialApp(
      initialRoute: '/login',
      // routes: {
      //   '/login': (context) => pageFactory.pageCreator(EnumPage.login),
      //   '/registration': (context) =>
      //       pageFactory.pageCreator(EnumPage.registration),
      //   '/work': (context) => pageFactory.pageCreator(EnumPage.work),
      // },
      title: 'Table App',
      theme: themeFactory.themeCreator(enumTheme),
      onGenerateRoute: (settings) {
        var path = settings.name?.split('/');

        switch (path?[1]) {
          case "login":
            enumPage = EnumPage.login;
            break;
          case "registration":
            enumPage = EnumPage.registration;
            break;
          case "work":
            enumPage = EnumPage.work;
            break;
          default:
            enumPage = EnumPage.none;
            break;
        }

        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: pageFactory.pageCreator(enumPage),
          ),
          settings: settings,
        );
      },
    );
  }
}

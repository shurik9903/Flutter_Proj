import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modules/RoutePage.dart';
import 'theme/ThemeFactory.dart';

class SelectTheme extends ChangeNotifier {
  EnumTheme _enumTheme = EnumTheme.dark;

  set theme(EnumTheme theme) {
    _enumTheme = theme;
    notifyListeners();
  }

  EnumTheme get theme => _enumTheme;

  void change() {
    if (_enumTheme == EnumTheme.dark) {
      _enumTheme = EnumTheme.light;
    } else {
      _enumTheme = EnumTheme.dark;
    }
    notifyListeners();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SelectTheme _selectTheme = SelectTheme();
  EnumPage _enumPage = EnumPage.none;

  @override
  Widget build(BuildContext context) {
    RoutePageFactory pageFactory = RoutePageFactory();
    ThemeFactory themeFactory = ThemeFactory();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _selectTheme,
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          initialRoute: '/login',
          title: 'Table App',
          theme: themeFactory.themeCreator(context.watch<SelectTheme>().theme),
          onGenerateRoute: (settings) {
            var path = settings.name?.split('/');

            switch (path?[1]) {
              case "login":
                _enumPage = EnumPage.login;
                break;
              case "registration":
                _enumPage = EnumPage.registration;
                break;
              case "work":
                _enumPage = EnumPage.work;
                break;
              default:
                _enumPage = EnumPage.none;
                break;
            }

            return MaterialPageRoute(
              builder: (context) => Scaffold(
                body: pageFactory.pageCreator(_enumPage),
              ),
              settings: settings,
            );
          },
        );
      },
    );
  }
}

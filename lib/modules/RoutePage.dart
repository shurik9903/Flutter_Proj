import 'package:flutter/material.dart';

import '../pages/WorkPage.dart';
import '../pages/LoginPage.dart';
import '../pages/RegistrationPage.dart';

enum EnumPage { none, work, registration, login }

class RoutePageFactory {
  Widget pageCreator(EnumPage enumPage) {
    Widget page = Container();

    switch (enumPage) {
      case EnumPage.work:
        page = const WorkPage();
        break;
      case EnumPage.registration:
        page = const RegistrationPage();
        break;
      case EnumPage.login:
        page = const LoginPage();
        break;
      case EnumPage.none:
        page = Container();
        break;
    }

    return page;
  }
}

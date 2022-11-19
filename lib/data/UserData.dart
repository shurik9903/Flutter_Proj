// class UserData_class extends ChangeNotifier {
//   String _id = '';
//   String _login = '';
//   String _token = '';

//   set id(String id) {
//     _id = id;
//     notifyListeners();
//   }

//   String get id => _id;

//   set login(String login) {
//     _login = login;
//     notifyListeners();
//   }

//   String get login => _login;

//   set token(String token) {
//     _token = token;
//     notifyListeners();
//   }

//   String get token => _token;
// }

abstract class UserDataBase {
  String _id = '';
  String _login = '';
  String _token = '';

  set id(String id) => _id = id;

  String get id => _id;

  set login(String login) => _login = login;

  String get login => _login;

  set token(String token) => _token = token;

  String get token => _token;
}

class UserData_Singleton extends UserDataBase {
  static final UserData_Singleton _singleton =
      UserData_Singleton._constructor();

  factory UserData_Singleton() {
    return _singleton;
  }

  UserData_Singleton._constructor();
}

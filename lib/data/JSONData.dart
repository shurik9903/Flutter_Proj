class LoginData {
  LoginData({this.msg, this.userID, this.userName, this.token});

  final String? msg;
  final String? userID;
  final String? userName;
  final String? token;

  factory LoginData.fromJson(Map<String, dynamic> data) {
    final msg = data['Msg'] as String?;
    final userID = data['UserID'] as String?;
    final userName = data['UserName'] as String?;
    final token = data['Token'] as String?;
    return LoginData(
        msg: msg, userID: userID, userName: userName, token: token);
  }
}

class RegistrationData {
  RegistrationData({this.msg});

  final String? msg;

  factory RegistrationData.fromJson(Map<String, dynamic> data) {
    final msg = data['Msg'] as String?;

    return RegistrationData(msg: msg);
  }
}

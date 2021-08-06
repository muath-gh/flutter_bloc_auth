import 'package:bloc_auth/models/user.dart';

class LoginResponse {
  bool success;
  User user;
  String message;
  String token;

  LoginResponse({this.success, this.user, this.message, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = true;
    user = User.fromJson(json['user'] as Map<String, dynamic>);
    message = json['message'].toString();
    token = json['token'].toString();
  }

  LoginResponse.withError(String error) {
    success = false;
    user = null;
    message = error;
    token = '';
  }
}

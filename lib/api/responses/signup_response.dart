import 'package:bloc_auth/models/user.dart';

class SignUpResponse {
  bool success;
  User user;
  String message;
  String token;

  SignUpResponse({this.success, this.user, this.message, this.token});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    success = true;
    user = User.fromJson(json['user'] as Map<String, dynamic>);
    message = json['message'].toString();
    token = json['token'].toString();
  }

  SignUpResponse.withError(String error) {
    success = false;
    user = null;
    message = error;
    token = '';
  }
}

import 'package:bloc_auth/models/user.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginComplete extends LoginState {
  final User user;
  LoginComplete(this.user);
}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}

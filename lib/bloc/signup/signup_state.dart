import 'package:bloc_auth/models/user.dart';

abstract class SignUpState {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpComplete extends SignUpState {
  final User user;
  SignUpComplete(this.user);
}

class SignUpError extends SignUpState {
  final String error;
  SignUpError(this.error);
}

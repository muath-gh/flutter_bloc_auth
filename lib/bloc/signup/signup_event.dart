abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUp extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  SignUp(this.name, this.email, this.password);
}

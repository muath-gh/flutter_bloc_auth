abstract class LoginEvent {
  const LoginEvent();
}

class Login extends LoginEvent {
  final String email;
  final String password;
  Login(this.email, this.password);
}

import 'package:bloc_auth/api/api_provider.dart';
import 'package:bloc_auth/api/responses/login_response.dart';
import 'package:bloc_auth/bloc/login/login_event.dart';
import 'package:bloc_auth/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiProvider _api;
  final storage = FlutterSecureStorage();
  LoginBloc() : super(LoginInitial()) {
    _api = ApiProvider();
  }
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      try {
        yield LoginLoading();
        LoginResponse response = await _api.login(event.email, event.password);
        if (response.success) {
          String token = response.token;
          await storage.write(key: "access_token", value: token);

          yield LoginComplete(response.user);
        } else {
          yield LoginError(response.message);
        }
      } catch (error) {
        yield LoginError("something went wrong");
      }
    }
  }
}

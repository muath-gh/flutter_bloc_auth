import 'package:bloc_auth/api/api_provider.dart';
import 'package:bloc_auth/api/responses/signup_response.dart';
import 'package:bloc_auth/bloc/signup/signup_event.dart';
import 'package:bloc_auth/bloc/signup/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  ApiProvider _api;
  final storage = FlutterSecureStorage();
  SignUpBloc() : super(SignUpInitial()) {
    _api = ApiProvider();
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUp) {
      try {
        yield SignUpLoading();
        SignUpResponse signUpResponse =
            await _api.signup(event.name, event.email, event.password);
        if (signUpResponse.success) {
          String token = signUpResponse.token;
          await storage.write(key: "access_token", value: token);
          yield SignUpComplete(signUpResponse.user);
        } else {
          yield SignUpError(signUpResponse.message);
        }
      } catch (error) {
        yield SignUpError("something went wrong");
      }
    }
  }
}

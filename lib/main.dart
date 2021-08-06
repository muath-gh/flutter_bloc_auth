import 'package:bloc_auth/bloc/login/login_bloc.dart';
import 'package:bloc_auth/bloc/signup/signup_bloc.dart';
import 'package:bloc_auth/screens/home_screen.dart';
import 'package:bloc_auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login/login_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

bool _isAuth = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();
  final String token = await storage.read(key: "access_token");
  if (token != null && token.isNotEmpty) {
    _isAuth = true;
  }
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_isAuth);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => SignUpBloc())
        ],
        child: _isAuth
            ? MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
                theme: ThemeData(fontFamily: "BebasNeue-Regular"),
              )
            : BlocBuilder<LoginBloc, LoginState>(
                builder: (_, state) {
                  if (state is LoginInitial) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: LoginScreen(false),
                      theme: ThemeData(fontFamily: "BebasNeue-Regular"),
                    );
                  } else if (state is LoginLoading) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: LoginScreen(true),
                      theme: ThemeData(fontFamily: "BebasNeue-Regular"),
                    );
                  } else if (state is LoginComplete) {
                    return MaterialApp(
                      home: HomeScreen(),
                      theme: ThemeData(fontFamily: "BebasNeue-Regular"),
                    );
                  }
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: LoginScreen(false),
                    theme: ThemeData(fontFamily: "BebasNeue-Regular"),
                  );
                },
              ));
  }
}

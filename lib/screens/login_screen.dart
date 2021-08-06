import 'package:bloc_auth/bloc/login/login_event.dart';
import 'package:bloc_auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc_auth/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  final bool showIndicator;
  LoginScreen(this.showIndicator);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordHidden = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.black, fontSize: 30),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    height: 200,
                    child: Image.asset(
                      "assets/images/tg.png",
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: BorderSide(color: Colors.red, width: 0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "this field is required";
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: _passwordHidden,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordHidden = !_passwordHidden;
                            });
                          },
                          icon: _passwordHidden
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: BorderSide(color: Colors.red, width: 0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "this field is required";
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.showIndicator)
                    CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () {
                          _login();
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 25, color: Colors.red),
                        ),
                      ),
                      Container(
                        child: Image.asset(
                          "assets/images/mini_k.png",
                          height: 200,
                          width: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SignUpScreen()));
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 25),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text("© 2021 MUATH-GH All Rights Reserved")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      loginBloc.add(Login(email, password));
    }
  }
}

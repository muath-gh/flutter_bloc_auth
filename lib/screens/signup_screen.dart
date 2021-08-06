import 'package:bloc_auth/bloc/signup/signup_bloc.dart';
import 'package:bloc_auth/bloc/signup/signup_event.dart';
import 'package:bloc_auth/bloc/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (_, state) {
        Widget child = SignUpForm(false);
        if (state is SignUpLoading) {
          child = SignUpForm(true);
        }
        if (state is SignUpComplete) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
            theme: ThemeData(fontFamily: "BebasNeue-Regular"),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: child,
            appBar: AppBar(
              title: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.black, fontSize: 30),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.red,
            ),
          ),
          theme: ThemeData(fontFamily: "BebasNeue-Regular"),
        );
      },
    );
  }
}

class SignUpForm extends StatefulWidget {
  final bool showIndicator;

  SignUpForm(this.showIndicator);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordHidden = true;
  SignUpBloc signUpBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
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
                controller: _nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Name",
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
                  prefixIcon: Icon(Icons.lock),
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
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) return "this field is required";
                  if (value.length < 8)
                    return "The password must be at least 8 characters";
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
              FlatButton(
                onPressed: () {
                  _signup();
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text("© 2021 MUATH-GH All Rights Reserved")
            ],
          ),
        ),
      ),
    );
  }

  void _signup() {
    if (_formKey.currentState.validate()) {
      final String name = _nameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      signUpBloc.add(SignUp(name, email, password));
    }
  }
}

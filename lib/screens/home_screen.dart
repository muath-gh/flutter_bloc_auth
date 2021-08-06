import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../main.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                onPressed: () {
                  _logout(context);
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: "access_token");
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => Main()));
  }
}

import 'package:break_app/firebase/database.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
// this page handles auth!

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Login / Sign Up Page",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
        ),
        backgroundColor: Color(0xECEAEA),
        shadowColor: Color(0xECEAEA),
        surfaceTintColor: Color(0xECEAEA),
        foregroundColor: Color(0xECEAEA),
      ),
      body: ElevatedButton(
        child: Text("Login"),
        onPressed: () async {
          var profile = await DatabaseService().getUser();
          inspect(profile);
          profile.restTime = 0;
          inspect(profile);
          DatabaseService().updateUser(profile);
          //Navigator.pushNamed(context, '/Home');
        },
      ),
    );
  }
}

import 'package:break_app/firebase/database.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import '../firebase/auth.dart';
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
          //FOR SIGN UP- need to diff username than DB
          //AuthService().register("test", "test12345");
          var profile =
              await AuthService().signIn("test1", "test12345"); //FOR LOG IN

          //GET data for a UID
          var data = await DatabaseService(uid: profile.uid).getUser();
          inspect(data);

          //UDPATE data- edit breakUser and pass into updateUser()
          // data.restTime = 0;
          // DatabaseService().updateUser(data);

          //Navigator.pushNamed(context, '/Home');
        },
      ),
    );
  }
}

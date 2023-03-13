import 'package:flutter/material.dart';

// this page handles auth!

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Login / Sign Up Page",
        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
        ),
        backgroundColor: Color(0xECEAEA),
        shadowColor: Color(0xECEAEA),
        surfaceTintColor: Color(0xECEAEA),
        foregroundColor:  Color(0xECEAEA),
      ),

      body: ElevatedButton(
        child: Text("Login"),
        onPressed: (){
          Navigator.pushNamed(context, '/Home');
        } ,
      ),

    );
  }
}
import 'package:break_app/firebase/database.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import '../firebase/auth.dart';
import 'package:break_app/colors/colors.dart';
import 'package:break_app/screens/home_utils/clickableText.dart';
// this page handles auth!

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  bool showText = false;
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
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
          ),
          backgroundColor: Color(0xECEAEA),
          shadowColor: Color(0xECEAEA),
          surfaceTintColor: Color(0xECEAEA),
          foregroundColor: Color(0xECEAEA),
        ),
        body: Container(
            padding: EdgeInsets.all(60),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(80),
                  child: Text(
                    "REQUIEM",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: DarkGreen,
                        fontSize: 25),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: TextFormField(
                            controller: _usernameController,
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: "Username",
                                  hintStyle: TextStyle(fontSize: 15))),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: TextFormField(
                            controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.key),
                                  hintText: "Password",
                                  hintStyle: TextStyle(fontSize: 15))),
                        ),
                      ],
                    )),
                Container(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [Visibility(
                        visible: showText,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Invalid username or password!",
                        style: TextStyle(color: Colors.red, fontSize: 15),),
                        )
                      ),
                        ElevatedButton(
                      child: Text("Sign in",
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        primary: DarkGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: const Size(350, 30),
                      ),
                      onPressed: () async {
                        var profile = await AuthService()
                            .signIn(_usernameController.text, _passwordController.text); 
                        //GET data for a UID
                        if (profile != null){
                          var data =
                            await DatabaseService(uid: profile.uid).getUser();
                          inspect(data);
                          Navigator.pushNamed(context, '/Home');
                        }
                        else {
                          setState(() {
                            showText=true;
                          });
                        }
                      },
                    )
                      ],
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?   "),
                        ClickableUnderlineText(
                            text: "Sign up",
                            onTap: () {
                              // route to signup page
                              Navigator.pushNamed(context, '/Signup');
                            }),
                      ],
                    )),
              ],
            )));
  }
}

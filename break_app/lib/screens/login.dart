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
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: "Username",
                                  hintStyle: TextStyle(fontSize: 15))),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: TextFormField(
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
                    child: ElevatedButton(
                      child: Text("Sign in",
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        primary: DarkGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: const Size(350, 30),
                      ),
                      onPressed: () async {
                        // sign up with google
                        //FOR SIGN UP- need to diff username than DB
                        //AuthService().register("test", "test12345");
                        var profile = await AuthService()
                            .signIn("test1", "test12345"); //FOR LOG IN

                        //GET data for a UID
                        var data =
                            await DatabaseService(uid: profile.uid).getUser();
                        inspect(data);

                        //UDPATE data- edit breakUser and pass into updateUser()
                        // data.restTime = 0;
                        // DatabaseService().updateUser(data);

                        //Navigator.pushNamed(context, '/Home');
                      },
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

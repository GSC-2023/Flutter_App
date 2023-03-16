import 'package:break_app/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:break_app/colors/colors.dart';
import 'package:break_app/screens/home_utils/clickableText.dart';

// this page handles signup!

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Sign Up",
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
                  padding: EdgeInsets.all(50),
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: _usernameController,
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.person),
                                        hintText: "Username",
                                        hintStyle: TextStyle(fontSize: 15)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a valid username';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.key),
                                          hintText: "Password",
                                          hintStyle: TextStyle(fontSize: 15)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      }),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                      controller: _confirmPasswordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.key),
                                          hintText: "Confirm Password",
                                          hintStyle: TextStyle(fontSize: 15)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please confirm your password';
                                        }
                                        if (value != _passwordController.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                    padding: EdgeInsets.all(25),
                    child: ElevatedButton(
                      child: Text("Sign up",
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        primary: DarkGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: const Size(350, 30),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //FOR SIGN UP- need to diff username than DB
                          Navigator.pushNamed(context, '/Home');
                        }
                        // sign up with google
                      },
                    )),
              ],
            )));
  }
}

import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/activities.dart';
import './screens/statistics.dart';
import './screens/social.dart';
import './screens/settings.dart';
import './screens/socialSingle.dart';





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder> {
        '/' : (context) => Home(),
        '/Home' : (context) => Home(),
        '/Activities' : (context) => Activities(),
        '/Social' : (context) => Social(),
        '/Statistics' : (context) => Statistics(),
        '/Settings' : (context) => Settings(),
        '/SocialSingle': (context) => SocialSingle(),

      },
    );
  }
}

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold();
  }
}











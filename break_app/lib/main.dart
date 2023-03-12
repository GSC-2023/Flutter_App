import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/activities.dart';
import './screens/statistics.dart';
import './screens/social.dart';
import './screens/settings.dart';
import 'package:break_app/screens//home.dart';
import 'package:break_app/screens/activities.dart';
import 'package:break_app/screens/statistics.dart';
import 'package:break_app/screens/social.dart';
import 'package:break_app/screens/settings.dart';
import 'package:break_app/screens/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      routes: <String, WidgetBuilder>{
        '/': (context) => Login(),
        '/Home': (context) => Home(),
        '/Activities': (context) => Activities(),
        '/Social': (context) => Social(),
        '/Statistics': (context) => Statistics(),
        '/Settings': (context) => Settings(),
        '/PhysicalActivites': (context) => PhysicalActivites(),
        '/PhysicalActivites/ReliefExercises': (context) =>
            PhysicalReliefExercises(),
        '/PhysicalActivites/RecommendPath': (context) =>
            PhysicalRecommendPath(),
        '/PhysicalActivites/ReliefExercises/Info': (context) =>
            Physical_Relief_Exercise_Info(),
        '/MentalActivites': (context) => MentalActivites(),
        '/MentalActivites/Breathing': (context) => Mental_Breathing(),
        '/MentalActivites/Podcast': (context) => Mental_Podcast(),


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











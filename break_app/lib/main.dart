import 'package:break_app/screens/activities/physical/physical_relief_exercises.dart';
import 'package:break_app/screens/activities/physical/physical_activities.dart';
import 'package:break_app/screens/activities/physical/physical_recommend_path.dart';
import 'package:break_app/screens/activities/physical/specific_exercises/physical_relief_exercise_neck.dart';
import 'package:flutter/material.dart';
import 'package:break_app/screens//home.dart';
import 'package:break_app/screens/activities.dart';
import 'package:break_app/screens/statistics.dart';
import 'package:break_app/screens/social.dart';
import 'package:break_app/screens/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => Home(),
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
        '/PhysicalActivites/ReliefExercises/Neck': (context) =>
            Physical_Relief_Exercise_Neck(),
      },
    );
  }
}

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

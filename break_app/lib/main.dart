import 'package:break_app/screens/activities/mental/mental_activities.dart';
import 'package:break_app/screens/activities/mental/mental_breathing.dart';
import 'package:break_app/screens/activities/mental/mental_podcast.dart';
import 'package:break_app/screens/activities/physical/physical_relief_exercises.dart';
import 'package:break_app/screens/activities/physical/physical_activities.dart';
import 'package:break_app/screens/activities/physical/physical_recommend_path.dart';
import 'package:break_app/screens/activities/physical/physical_relief_exercise_info.dart';
import 'package:flutter/material.dart';
import 'package:break_app/screens//home.dart';
import 'package:break_app/screens/activities.dart';
import 'package:break_app/screens/statistics.dart';
import 'package:break_app/screens/social.dart';
import 'package:break_app/screens/settings.dart';
import 'package:break_app/screens/login.dart';
import 'package:break_app/screens/home_utils/break.dart';
import 'package:break_app/screens/signup.dart';

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
        '/Signup': (context) => SignUpPage(),
        '/Home': (context) => Home(),
        '/Break': (context) => Break(),
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
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

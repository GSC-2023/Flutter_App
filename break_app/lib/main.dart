import 'package:break_app/firebase/FaceDetection.dart';
import 'package:break_app/firebase/FaceDetectorView.dart';
import 'package:break_app/firebase/auth.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:break_app/screens/signup.dart';
import 'firebase/imageUpload.dart';
import 'models/profile.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<profile?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/': (context) => Login(),
          '/Signup': (context) => SignUpPage(),
          //'/': (context) => ImageUpload(),
          //'/': (context) => FaceDetection(),
          //'/': (context) => FaceDetectorView(),
          '/Home': (context) => Home(),
          '/Break': (context) => Break(),
          '/Activities': (context) => Activities(),
          '/Social': (context) => Social(),
          '/Statistics': (context) => Statistics(),
          '/Settings': (context) => Settings(),
          '/PhysicalActivities': (context) => PhysicalActivities(),
          '/PhysicalActivities/ReliefExercises': (context) =>
              PhysicalReliefExercises(),
          '/PhysicalActivities/RecommendPath': (context) =>
              PhysicalRecommendPath(),
          '/PhysicalActivities/ReliefExercises/Info': (context) =>
              Physical_Relief_Exercise_Info(),
          '/MentalActivities': (context) => MentalActivities(),
          '/MentalActivities/Breathing': (context) => Mental_Breathing(),
          '/MentalActivities/Podcast': (context) => Mental_Podcast(),
        },
      ),
    );
  }
}

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

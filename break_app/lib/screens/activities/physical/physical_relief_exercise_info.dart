import 'package:break_app/colors/colors.dart';
import 'package:break_app/screens/activities/physical/components/exerciseCard.dart';
import 'package:flutter/material.dart';
import 'package:break_app/misc_utils/customDrawer.dart';

class Physical_Relief_Exercise_Info extends StatelessWidget {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    String title = data['title'];
    String instructions = data['content'];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Activities",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
        ),
        backgroundColor: Color(0xECEAEA),
        shadowColor: Color(0xECEAEA),
        surfaceTintColor: Color(0xECEAEA),
        foregroundColor:  Color(0xECEAEA),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "${title} Stretching Exercise",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'League Spartan',
                  color: DarkGreen,
                ),
              ),
              padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   child: Image.asset(
            //     'assets/images/stretches/${title}.jpg',
            //     height: 300,
            //     width: 400,
            //   ),
            // ),
            ExerciseCard(
              instructions: instructions,
              title: title,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:break_app/colors/colors.dart';
import 'package:break_app/screens/activities/physical/components/exerciseButton.dart';
import 'package:flutter/material.dart';
import 'package:break_app/misc_utils/customDrawer.dart';

class PhysicalReliefExercises extends StatelessWidget {
  final parts = ['Neck', 'Core', 'Arms', 'Glutes', 'Legs', 'Shoulders'];
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Select an Exercise",
                style: TextStyle(
                  fontSize: 20,
                  color: DarkGreen,
                ),
              ),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, int index) {
                  return ExerciseButton(name: parts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ExerciseButton extends StatelessWidget {
  final String name;
  ExerciseButton({required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            '/PhysicalActivities/ReliefExercises/Info',
            arguments: {
              'title': name,
              'content': //content is fixed for now
                  '1. Bend your head forward and slightly to the right.\n2. With your right hand, gently pull your head downward. You\'ll feel a nice, easy stretch along the back left side of your neck.\n3. Hold for about 30 seconds.\n4. Repeat on the opposite side.',
            },
          );
        },
        child: Column(
          children: [
            Text(
              '${name}',
              style: TextStyle(fontSize: 30),
            ),
            Image.asset('assets/icons/${name}.png'),
          ],
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        ),
      ),
    );
  }
}

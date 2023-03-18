import 'package:flutter/material.dart';
import 'package:break_app/colors/colors.dart';

class ExerciseCard extends StatelessWidget {
  final String instructions;
  final String title;
  ExerciseCard({required this.instructions, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: White,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/stretches/${title}.jpg',
                height: 300,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Steps: ',
              style: TextStyle(
                  fontSize: 30,
                  color: DarkGreen,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'League Spartan'
                ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              instructions,
              style: TextStyle(
                fontSize: 25,
                color: DarkGreen,
                fontFamily: 'League Spartan'
              ),
            ),
          ),
        ],
      ),
    );
  }
}

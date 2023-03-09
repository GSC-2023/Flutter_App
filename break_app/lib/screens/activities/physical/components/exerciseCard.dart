import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final String instructions;
  ExerciseCard({required this.instructions});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.grey[400],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              'Steps: ',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              instructions,
              style: TextStyle(
                fontSize: 25,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

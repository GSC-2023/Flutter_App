import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    //String name = data['title'];
    String instructions = data['content'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Steps: ',
          style: TextStyle(
            fontSize: 36,
            color: Colors.green,
          ),
        ),
        Container(
          color: Colors.grey[400],
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            instructions,
            style: TextStyle(
              fontSize: 36,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}

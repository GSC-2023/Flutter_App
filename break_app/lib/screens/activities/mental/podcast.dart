import 'package:break_app/screens/activities/mental/VideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:break_app/colors/colors.dart';

class Podcast extends StatelessWidget {
  final String type;
  Podcast({ required this.type });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: White,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: Offset(10.0, 25.0),
            blurRadius: 70.0
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            child: Text(
              'Soothing Podcast',
              style: TextStyle(
                fontSize: 20,
                color: DarkGreen,
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 30, 0, 100),
          ),

          Container(
            child: VideoApp(type: this.type),
            padding: EdgeInsets.fromLTRB(10, 20, 10, 50),
          ),
          
        ],
      ),
    );
  }
}

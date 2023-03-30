import 'package:flutter/material.dart';
import 'package:break_app/misc_utils/customDrawer.dart';

import '../../../colors/colors.dart';
import 'VideoPlayer.dart';

class Mental_Breathing extends StatelessWidget {
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
        foregroundColor: Color(0xECEAEA),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Breathing Exercise',
                    style: TextStyle(
                      fontSize: 20,
                      color: DarkGreen,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                ),
                Container(
                  // decoration: BoxDecoration(
                  //       shape: BoxShape.rectangle,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.shade400,
                  //           offset: Offset(0, 0),
                  //           blurRadius: 5.0
                  //         )
                  //       ]
                  //     ),
                  child: VideoApp(type: 'breathing'),
                ),
              ],
            ),
            //child: YoutubeWidget(),//doesnt work for android
          ),
        ],
      ),
    );
  }
}

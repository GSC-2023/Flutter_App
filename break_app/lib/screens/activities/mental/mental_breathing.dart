import 'package:flutter/material.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:break_app/screens/activities/mental/podcast.dart';

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
          Podcast(type: 'breathing')
        ],
      ),
    );
  }
}

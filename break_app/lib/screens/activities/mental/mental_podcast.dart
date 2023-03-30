import 'package:break_app/screens/activities/mental/YoutubeVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'VideoPlayer.dart';
import 'package:break_app/colors/colors.dart';
import 'package:break_app/screens/activities/mental/podcast.dart';

class Mental_Podcast extends StatelessWidget {
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
            Podcast(type: 'soothing',)
          ]
      ),
    );
  }
}

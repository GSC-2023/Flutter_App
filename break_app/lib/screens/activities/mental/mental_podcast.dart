import 'package:break_app/screens/activities/mental/YoutubeVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'VideoPlayer.dart';

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
        foregroundColor: Color(0xECEAEA),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Text(
              'Soothing Podcast',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color(0xff2E593F),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            VideoApp(),
          ],
        ),
        //child: YoutubeWidget(),//doesnt work for android
      ),
    );
  }
}

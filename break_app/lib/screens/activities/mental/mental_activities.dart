import 'package:flutter/material.dart';
import 'package:break_app/misc_utils/customDrawer.dart';

class MentalActivities extends StatelessWidget {
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
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "What activity would you like to do?",
                style: TextStyle(fontSize: 24),
              ),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/MentalActivities/Breathing');
                        },
                        icon: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Breathing Exercises',
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              'Est Duration: 2min',
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        label: Image.asset('assets/icons/Breathing.png'),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                              vertical: 60.0, horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      icon: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Soothing Podcast',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            'Est Duration: 5min',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/MentalActivities/Podcast');
                      },
                      label: Image.asset('assets/icons/Podcast.png'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                            vertical: 60.0, horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

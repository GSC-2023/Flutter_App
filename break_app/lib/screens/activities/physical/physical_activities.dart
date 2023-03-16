import 'package:flutter/material.dart';
import 'package:break_app/misc_utils/customDrawer.dart';

class PhysicalActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer:CustomDrawer(),
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
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        icon: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Relief Exercises',
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              'Est Duration: 3min',
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/PhysicalActivities/ReliefExercises');
                        },
                        label: Image.asset('assets/icons/Stretch.png'),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 50.0),
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
                            'Take a Walk',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            'Est Duration: +5min',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/PhysicalActivities/RecommendPath');
                      },
                      label: Image.asset('assets/icons/Walk.png'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 50.0),
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

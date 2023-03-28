import 'package:flutter/material.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:getwidget/getwidget.dart';
import 'package:break_app/colors/colors.dart';


class MentalActivities extends StatelessWidget {
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
        shadowColor: Color(0xECEAEA),
        surfaceTintColor: Color(0xECEAEA),
        foregroundColor:  Color(0xECEAEA),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "What activity would you like to do?",
                style: TextStyle(
                  fontSize: 20,
                  color: DarkGreen,
                ),
              ),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
            ),
            Container(
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(10.0, 25.0),
                            blurRadius: 70.0
                          )
                        ]
                      ),
                      child: GFImageOverlay(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        height: 200,
                        width: double.infinity,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Breathing Exercises',
                                style: TextStyle(
                                  color: White,
                                  fontSize: 30,
                                  fontFamily: 'League Spartan'
                                ),
                              ),
                              Text(
                                'Est Duration: 2 min',
                                style: TextStyle(
                                  color: White,
                                  fontSize: 15,
                                  fontFamily: 'League Spartan'
                                ),
                              ),
                            ],
                          ),
                        ),
                        image: AssetImage('assets/images/Breathing.png'),
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context, '/MentalActivities/Breathing');
                    },
                  ),
                  
                  SizedBox(
                    height: 50,
                  ),

                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(10.0, 25.0),
                            blurRadius: 70.0
                          )
                        ]
                      ),
                      child: GFImageOverlay(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        height: 200,
                        width: double.infinity,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Soothing Podcast',
                                style: TextStyle(
                                  color: White,
                                  fontSize: 30,
                                  fontFamily: 'League Spartan'
                                ),
                              ),
                              Text(
                                'Est Duration: 5+ min',
                                style: TextStyle(
                                  color: White,
                                  fontSize: 15,
                                  fontFamily: 'League Spartan'
                                ),
                              ),
                            ],
                          ),
                        ),
                        image: AssetImage('assets/images/Podcast.png'),
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.0), BlendMode.darken),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context, '/MentalActivities/Podcast');
                    },
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

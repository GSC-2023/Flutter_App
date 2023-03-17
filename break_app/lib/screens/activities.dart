import 'package:break_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:break_app/misc_utils/customDrawer.dart';

class Activities extends StatelessWidget {
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "What would you like to do?",
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
                            offset: Offset(0.0, 20.0),
                            blurRadius: 50.0
                          )
                        ]
                      ),
                      alignment: Alignment.center,
                      child: GFImageOverlay(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        height: 200,
                        width: double.infinity,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'Physical',
                            style: TextStyle(
                              color: White,
                              fontSize: 30,
                              letterSpacing: 7,
                              fontFamily: 'League Spartan'
                            ),
                          ),
                        ),
                        image: AssetImage('assets/images/Physical_bg.png'),
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/PhysicalActivities');
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
                            offset: Offset(0.0, 20.0),
                            blurRadius: 50.0
                          )
                        ]
                      ),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: double.infinity,
                        child: GFImageOverlay(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          height: 200,
                          width: double.infinity,
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Text(
                              'Mental',
                              style: TextStyle(
                                  color: White,
                                  fontSize: 30,
                                  letterSpacing: 7,
                                  fontFamily: 'League Spartan'),
                            ),
                          ),
                          image: AssetImage('assets/images/Mental_bg.png'),
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.darken),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/MentalActivities');
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

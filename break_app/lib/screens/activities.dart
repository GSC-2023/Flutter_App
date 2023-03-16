import 'package:flutter/material.dart';
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
        foregroundColor: Color(0xECEAEA),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "What would you like to do?",
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
                        icon: Text(
                          'Physical',
                          style: TextStyle(fontSize: 40),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/PhysicalActivites');
                        },
                        label: Image.asset('assets/icons/Physical.png'),
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
                  Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        icon: Text(
                          'Mental  ',
                          style: TextStyle(fontSize: 40),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/MentalActivites');
                        },
                        label: Image.asset('assets/icons/Mental.png'),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 50),
                        ),
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

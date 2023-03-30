import 'dart:developer';

import 'package:break_app/colors/colors.dart';
import 'package:break_app/models/breakUser.dart';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:getwidget/getwidget.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:provider/provider.dart';
import 'package:break_app/firebase/database.dart';


import 'package:break_app/models/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool started = false;
  bool paused = false; // used by pause/continue button
  bool completed = false;
  bool restartPressed = false;
  final CountDownController controller = new CountDownController();
  late profile user;
  late breakUser bu;
  late int userWorkTime;
  bool isLoading = true;
  

  /* This alert is called when the timer naturally runs down and redirects user to break page */
  showNaturalBreakAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Start My Break"),
      onPressed: () {
        int time = userWorkTime - (controller.getTimeInSeconds() / 60).ceil();
        user.userWorkMinutesElapsed += time;
        print("Cumulative work time increased by: $time");
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/Break');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("It's time for a break!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /* This alert is called when the timer is forcefully disrupted by user */
  showForcedBreakAlertDialog(BuildContext context) {
    // set up the button
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {
        int time = userWorkTime - (controller.getTimeInSeconds() / 60).ceil();
        user.userWorkMinutesElapsed += time;
        print("Cumulative work time increased by: $time");
        Navigator.of(context).pop(); // dismiss dialog
        Navigator.pushNamed(context, '/Break');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Do you wish to take a break now?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /* This alert is called when the user clicks on the `End Work` button */
  showForcedEndDayalertDialog(BuildContext context) {
    // set up the button
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirm"),
      onPressed: () async {
        int _work = user.userWorkMinutesElapsed;
        int _break = user.userBreakMinutesElapsed;
        print("Ended. Work: $_work, Break: $_break");
        bu.addDailyStatsNow(_work, _break, 0, -1);
        print("Daily stats updated.");
        print(bu.dailyStats);

        await DatabaseService().updateUser(bu, user.uid);

        Navigator.of(context).pop(); // dismiss dialog
        Navigator.pushNamed(context, '/Statistics');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure you wish to end your work day now?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> getBreakUser(user) async {
    bu = await DatabaseService().getUser(user.uid);
    // print("entered... ");
    // inspect(bu);

    setState(() {
      userWorkTime = bu.workTime;
      bu.onBreak = false;
      isLoading=false;
    });

    print("Work Duration: $userWorkTime");
    await DatabaseService().updateUser(bu, user.uid);
    bool breakStatus = bu.onBreak;
    print("Updated BreakStatus: $breakStatus");
  }

  // Future<void> endWork() async {
  //   bu.addDailyStatsNow(args, widget.userBreakMinutesElapsed, -1, -1);
  // }

  @override
  void initState() {
    super.initState();
    // user = Provider.of<profile>(context);
    // inspect(user);

    WidgetsBinding.instance.addPostFrameCallback((Timestamp) {
      user = Provider.of<profile>(context, listen: false);
      getBreakUser(user);
    });

  }


  @override
  Widget build(BuildContext context) {
    user = Provider.of<profile>(context);
    getBreakUser(user);
    // inspect(user);
    // inspect(bu);

    return Scaffold(
      backgroundColor: Grey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Home",
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
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Text(
                started ? "Time to focus!" : "Click 'Begin Work' to start",
                style: TextStyle(
                  fontSize: 25,
                  color: DarkGreen,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(0.0, 20.0),
                    blurRadius: 30.0)
              ]),
              child: isLoading ?
              Container():
              NeonCircularTimer(
                  onComplete: () {
                    setState(() {
                    });
                    if (!restartPressed) showNaturalBreakAlertDialog(context);
                  },
                  width: 250,
                  controller: controller,
                  // duration: userWorkTime*60,
                  duration: userWorkTime*60,
                  autoStart: false,
                  strokeWidth: 5,
                  isTimerTextShown: true,
                  neumorphicEffect: true,
                  outerStrokeColor: Colors.grey.shade100,
                  isReverse: true,
                  isReverseAnimation: true,
                  innerFillGradient: LinearGradient(colors: [
                    DarkGreen,
                    Colors.green,
                  ]),
                  neonGradient: LinearGradient(colors: [
                    DarkGreen,
                    Colors.green,
                  ]),
                  strokeCap: StrokeCap.round,
                  innerFillColor: White,
                  backgroudColor: White,
                  neonColor: Colors.blue.shade900),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  0, 0, 0, 0), // TEMP LEFT IN FOR EASY DEV STYLING
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(40, 80, 40, 0),
              width: double.infinity,
              height: 275,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 45,
                        child: GFButton(
                          onPressed: started
                              ? (paused
                                  ? () {
                                      controller.resume();
                                      setState(() {
                                        paused = false;
                                        started = true;
                                        restartPressed = false;
                                      });
                                    }
                                  : () {
                                      controller.pause();
                                      print(
                                        (controller.getTimeInSeconds() / 60).ceil()
                                      );
                                      setState(() {
                                        paused = true;
                                      });
                                    })
                              : null,
                          text: paused ? "Resume" : "Pause",
                          textColor: DarkGreen,
                          shape: GFButtonShape.pills,
                          color: White,
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 45,
                        child: GFButton(
                          onPressed: started
                              ? () {
                                  setState(() {
                                    started = true;
                                    paused = true;
                                    completed = false;
                                    restartPressed = true;
                                  });
                                  controller.restart();
                                  controller.pause();
                                  setState(() {});
                                }
                              : null,
                          text: "Restart",
                          textColor: DarkGreen,
                          shape: GFButtonShape.pills,
                          color: White,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                      decoration: started ? 
                        null : BoxDecoration(
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(10.0, 10.0),
                            blurRadius: 30.0
                          )
                        ]
                      ),
                      height: 45,
                      child: GFButton(
                        onPressed: started
                            ? () {
                                setState(() {
                                  completed = true;
                                });
                                showForcedBreakAlertDialog(context);
                              }
                            : () {setState(() { 
                              started = true;
                            });
                            controller.start();
                            },
                        text: started ? "Break Now" : "Begin Work",
                        textColor: White,
                        shape: GFButtonShape.pills,
                        color: DarkGreen,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Container(
                      height: 45,
                      child: GFButton(
                        onPressed: started
                            ? () {
                                completed = true;
                                showForcedEndDayalertDialog(context);
                              }
                            : null,
                        text: "End",
                        textColor: White,
                        shape: GFButtonShape.pills,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
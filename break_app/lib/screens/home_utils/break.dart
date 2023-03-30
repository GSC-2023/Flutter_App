import 'dart:developer';

import 'package:break_app/colors/colors.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../../firebase/database.dart';
import '../../models/breakUser.dart';
import '../../models/profile.dart';
import '../social.dart';

class Break extends StatefulWidget {
  @override
  _BreakState createState() => _BreakState();
}

class _BreakState extends State<Break> {
  bool started = false;
  bool paused = false; // used by pause/continue button
  bool completed = false;
  bool restartPressed = false;
  late breakUser bu;
  late profile user;
  List<String> onlineFriends = [];
  List<PhotoItem> users = [];
  bool loading = true;
  int userBreakTime = 60; // default

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Timestamp) {
      user = Provider.of<profile>(context, listen: false);
      _loadFriends();
    });
  }

    /* This alert is called when the timer naturally runs down and redirects user to work page */
  showNaturalWorkAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Start Work"),
      onPressed: () {
        int time = (controller.getTimeInSeconds() / 60).ceil();
        user.userBreakMinutesElapsed += time;
        print("Cumulative break time increased by: $time");
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/Home');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("It's time for work!"),
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
  showForcedWorkAlertDialog(BuildContext context) {
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
        int time = (controller.getTimeInSeconds() / 60).ceil();
        user.userBreakMinutesElapsed += time;
        print("Cumulative break time increased by: $time");
        Navigator.of(context).pop(); // dismiss dialog
        Navigator.pushNamed(context, '/Home');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Do you wish to start work now?"),
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
      onPressed: () {
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

  final CountDownController controller = new CountDownController();

  Future _loadFriends() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    bu = await DatabaseService().getUser(user.uid);
    var friends = bu.meetups.keys.toList();
    for (var friend in friends) {
      var friendUser = await DatabaseService().getUserWithName(friend);
      if (friendUser!.onBreak) {
        onlineFriends.add(friend);
      }
    }
    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;
    List<Map<String, dynamic>> files = [];
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      var name = file.fullPath.split('.')[0];
      if (onlineFriends.contains(name)) {
        files.add({
          "url": fileUrl, //to pull image from firebase storage
          "name": name,
        });
      }
    });
    for (var i = 0; i < files.length; i++) {
      users.add(PhotoItem(files[i]['url'], files[i]['name']));
    }
    setState(() {
      loading = false;
      userBreakTime = bu.restTime;
    });
    return;
  }

  Widget getFriendPics() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            "Friends on break:",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: 140,
          child: new ListView(
              scrollDirection: Axis.horizontal,
              children: users
                  .map(
                    (user) => Column(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Blue,
                            ),
                            borderRadius: BorderRadius.circular(150),
                            image: DecorationImage(
                              image: NetworkImage(user.image),
                              fit: BoxFit.fill,
                            ),
                          ),
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        ),
                        Text(
                          toBeginningOfSentenceCase(user.name)!,
                          style: TextStyle(
                            fontSize: 15,
                            // fontFamily:
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text(
                "Time to rest!",
                style: TextStyle(
                  fontSize: 25,
                  color: Blue,
                ),
              ),
            ),
            loading
                ? Container()
                : Container(
                    child: getFriendPics(),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  ),
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(0.0, 20.0),
                    blurRadius: 30.0)
              ]),
              child: NeonCircularTimer(
                  onComplete: () {
                    setState(() {});
                    if (!restartPressed) showNaturalWorkAlertDialog(context);
                  },
                  width: 250,
                  controller: controller,
                  // duration: userBreakTime*60, // only accepts seconds
                  duration: 5,
                  autoStart: false,
                  strokeWidth: 5,
                  isTimerTextShown: true,
                  neumorphicEffect: true,
                  outerStrokeColor: Colors.grey.shade100,
                  innerFillGradient: LinearGradient(colors: [
                    DarkBlue,
                    LightBlue,
                  ]),
                  neonGradient: LinearGradient(colors: [
                    DarkBlue,
                    LightBlue,
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
                                      setState(() {
                                        paused = true;
                                      });
                                    })
                              : null,
                          text: paused ? "Resume" : "Pause",
                          textColor: Blue,
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
                          textColor: Blue,
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
                      decoration: started
                          ? null
                          : BoxDecoration(
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade500,
                                      offset: Offset(10.0, 10.0),
                                      blurRadius: 30.0)
                                ]),
                      height: 45,
                      child: GFButton(
                        onPressed: started
                            ? () {
                                setState(() {
                                  completed = true;
                                });
                                showForcedWorkAlertDialog(context);
                              }
                            : () {
                                setState(() {
                                  started = true;
                                });
                                controller.start();
                              },
                        text: started ? "Go back to Work" : "Begin Break",
                        textColor: White,
                        shape: GFButtonShape.pills,
                        color: Blue,
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
                        text: "End Work",
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

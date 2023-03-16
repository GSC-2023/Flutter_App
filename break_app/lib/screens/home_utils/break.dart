import 'package:break_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:getwidget/getwidget.dart';


class Break extends StatefulWidget {
  @override
  _BreakState createState() => _BreakState();
}

class _BreakState extends State<Break> {
  bool started = false;
  bool paused = false; // used by pause/continue button
  bool completed = false;
  bool restartPressed = false;
  final CountDownController controller = new CountDownController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Grey,
      drawer: Container(
        width:200,
        child: Drawer(
        child: Column(
          children: <Widget>[
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('Home'),
            onTap: (){
              Navigator.pushNamed(context, '/Home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_activity_outlined),
            title: Text('Activities'),
            onTap: (){
              Navigator.pushNamed(context, '/Activities');
            },
          ),
          ListTile(
            leading: const Icon(Icons.child_care_rounded),
            title: Text('Social'),
            onTap: (){
              Navigator.pushNamed(context, '/Social');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_outlined),
            title: Text('Statistics'),
            onTap: (){
              Navigator.pushNamed(context, '/Statistics');
            },
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                dense: true,
                visualDensity: VisualDensity(vertical: -4),
                leading: Icon(
                  Icons.settings,
                ),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, '/Settings');
                },
              ),
            ),
          ),
          ],
        ),
      ),

      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Home",
        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
        ),
        backgroundColor: Color(0xECEAEA),
        shadowColor: Color(0xECEAEA),
        surfaceTintColor: Color(0xECEAEA),
        foregroundColor:  Color(0xECEAEA),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
            child: Text(
              "Time to rest!",
              style: TextStyle(
                fontSize: 25,
                color: Blue,
              ),
              ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(0.0, 20.0),
                  blurRadius: 30.0
                )
              ]
            ),
            child: NeonCircularTimer(
                        onComplete: () {
                          setState(() {
                          });
                          if (!restartPressed) showNaturalWorkAlertDialog(context);
                        },
                        width: 250,
                        controller: controller,
                        duration: 10,
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0), // TEMP LEFT IN FOR EASY DEV STYLING
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
                      onPressed: started ? (
                        paused ? () {
                          controller.resume();
                          setState(() {
                            paused = false;
                            started = true;
                            restartPressed = false;
                          });
                        } 
                        : 
                        () {
                        controller.pause();
                        setState(() {
                          paused = true;
                        });}
                      ) : null,
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
                      onPressed: started ? () { 
                        setState(() {
                          started = true;
                          paused = true;
                          completed = false;
                          restartPressed = true;
                      });                         
                        controller.restart();
                        controller.pause();
                        setState(() {
                        });
                      } : null,
                      text:"Restart",
                      textColor: Blue,
                      shape: GFButtonShape.pills,
                      color: White,
                    ),
                  ),
                ],),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child:
                    Container(
                        height: 45,
                        child: GFButton(
                        onPressed: started ? () { setState(() {
                          completed = true;
                        }); 
                        showForcedWorkAlertDialog(context);
                        } : null, 
                        text: "Go back to Work",
                        textColor: White,
                        shape: GFButtonShape.pills,
                        color: Blue,
                        ),
                      ),
                  ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: 
                    Container(
                      height: 45,
                      child: GFButton(
                      onPressed:started ? () {} : () {setState(() { 
                        started = true;
                      });
                      controller.start();
                      },
                      text: started ? "End Work" : "Begin Break",
                      textColor: White,
                      shape: GFButtonShape.pills,
                      color: started ? Colors.red : Colors.orange.shade600,
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


/* This alert is called when the timer naturally runs down and redirects user to work page */
showNaturalWorkAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("Start Work"),
    onPressed: () { 
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
    onPressed:  () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );
  Widget continueButton = TextButton(
    child: Text("Confirm"),
    onPressed:  () {
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
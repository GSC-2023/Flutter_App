import 'package:break_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:getwidget/getwidget.dart';
import 'package:break_app/misc_utils/customDrawer.dart';




class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool started = false;
  bool paused = false; // used by pause/continue button
  bool completed = false;
  final CountDownController controller = new CountDownController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Grey,
      drawer: CustomDrawer(),
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
              started ? "Time to focus!" : "Click 'Begin Work' to start",
              style: TextStyle(
                fontSize: 25,
                color: DarkGreen,
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
                            started = false;
                            completed = true; // TODO: display affirmation msg, then redirect to break page
                            Navigator.pushNamed(context, '/Break');
                          });
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
                      textColor: DarkGreen,
                      shape: GFButtonShape.pills,
                      color: White,
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 45,
                    child: GFButton(
                      onPressed: started ? () { 
                        controller.restart();
                        controller.pause();
                        setState(() {
                          started = true;
                          paused = true;
                      }); } : null,
                      text:"Restart",
                      textColor: DarkGreen,
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
                        Navigator.pushNamed(context, '/Break');
                        } : null, // TODO: similar to above (setState completed=true), but first ask for further confirmation
                        text: "Break Now",
                        textColor: White,
                        shape: GFButtonShape.pills,
                        color: DarkGreen,
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
                      onPressed: started ? () {} : () {setState(() { // TODO: ask for further confirmation, then exit to daily summary page
                        started = true;
                      });
                      controller.start();
                      },
                      text: started ? "End Work" : "Begin Work",
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
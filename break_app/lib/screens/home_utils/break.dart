import 'package:break_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:getwidget/getwidget.dart';


class Break extends StatefulWidget {
  @override
  _BreakState createState() => _BreakState();
}

class _BreakState extends State<Break> {
  bool paused = false; // used by pause/continue button
  bool completed = false;
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
                fontSize: 20,
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
                            completed = true; // TODO: display affirmation msg, then redirect to break page
                          });
                        },
                        width: 250,
                        controller: controller,
                        duration: 10,
                        autoStart: true,
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
                      onPressed: (
                        paused ? () {
                          controller.resume();
                          setState(() {
                            paused = false;
                          });
                        } 
                        : 
                        () {
                        controller.pause();
                        setState(() {
                          paused = true;
                        });}
                      ),
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
                      onPressed: () { 
                        controller.restart();
                        controller.pause();
                        setState(() {
                          paused = true;
                      }); },
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
                        onPressed: () { setState(() {
                          completed = true;
                          Navigator.pushNamed(context, '/Home');
                        }); }, // TODO: similar to above (setState completed=true), but first ask for further confirmation
                        text: "Go back to Work",
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
                      onPressed: () {setState(() { completed = true; // TODO: ask for further confirmation, then exit to daily summary page
                      });
                      },
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
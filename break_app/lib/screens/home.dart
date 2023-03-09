import 'package:break_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:break_app/screens/home_quote.dart';
import 'package:break_app/screens/home_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool started = false;
  bool isRunning = true;
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
            child: Center(
              child: Text(
                "This is a placeholder.",
                ),
            )
          ),
          Container(
            // padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                stops: [0, 0, 0.5],
                end: Alignment(0, 0.5),
                colors: [Colors.lightGreen, Color.lerp(Colors.lightGreen, DarkGreen,0.25)??Colors.lightGreen,DarkGreen],
              ),
              shape: BoxShape.circle,
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isRunning = !isRunning;
                  started = true;
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(250, 250),
                shape: const CircleBorder(),
                backgroundColor: Colors.transparent,
                // shadowColor: Colors.black,  
                // elevation: 15,
              ),
              child:
                started ? (isRunning ? Text('Pause') : Text('Resume')) : Text('Begin Work'),
            ),
          ),
          started ? HomeButton() : HomeQuote()
      ]),
    );
  }
}
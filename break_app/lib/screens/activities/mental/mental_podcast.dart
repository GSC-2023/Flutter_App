import 'package:flutter/material.dart';

class Mental_Podcast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: Container(
        width: 200,
        child: Drawer(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, '/Home');
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_activity_outlined),
                title: Text('Activities'),
                onTap: () {
                  Navigator.pushNamed(context, '/Activities');
                },
              ),
              ListTile(
                leading: const Icon(Icons.child_care_rounded),
                title: Text('Social'),
                onTap: () {
                  Navigator.pushNamed(context, '/Social');
                },
              ),
              ListTile(
                leading: const Icon(Icons.bar_chart_outlined),
                title: Text('Statistics'),
                onTap: () {
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
        title: Text(
          "Activities",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
        ),
        backgroundColor: Color(0xECEAEA),
        foregroundColor: Color(0xECEAEA),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "What activity would you like to do?",
              style: TextStyle(fontSize: 24),
            ),
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          SizedBox(
            child: TextButton.icon(
              icon: Text(
                'Relief Exercises',
                style: TextStyle(fontSize: 36),
              ),
              onPressed: () {},
              label: Icon(Icons.man),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          SizedBox(
            child: TextButton.icon(
              icon: Text(
                'Recommend A Path',
                style: TextStyle(fontSize: 36),
              ),
              onPressed: () {},
              label: Icon(Icons.man),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
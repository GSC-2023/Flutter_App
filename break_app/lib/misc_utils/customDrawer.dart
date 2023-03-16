import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            // ListTile(
            //   leading: const Icon(Icons.bar_chart_outlined),
            //   title: Text('Statistics'),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/Statistics');
            //   },
            // ),
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
    );
  }
}

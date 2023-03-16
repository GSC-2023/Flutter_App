import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Drawer(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 45, 0, 45),
          child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != '/Home'){
                  Navigator.pushNamed(context, '/Home');
                }
                else{
                  Navigator.pop(context);
                } 
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_activity_outlined),
              title: Text('Activities'),
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != '/Activities'){
                  Navigator.pushNamed(context, '/Activities');
                }
                else{
                  Navigator.pop(context);
                } 
              },
            ),
            ListTile(
              leading: const Icon(Icons.child_care_rounded),
              title: Text('Social'),
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != '/Social'){
                  Navigator.pushNamed(context, '/Social');
                }
                else{
                  Navigator.pop(context);
                } 
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
                if (ModalRoute.of(context)?.settings.name != '/Settings'){
                  Navigator.pushNamed(context, '/Settings');
                }
                else{
                  Navigator.pop(context);
                } 

                  },
                ),
              ),
            ),
          ],
        ),
        )
      ),
    );
  }
}

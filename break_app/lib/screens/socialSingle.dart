import 'package:flutter/material.dart';
import './social.dart';

class SocialSingle extends StatelessWidget {
  const SocialSingle({super.key, required this.users});

  final PhotoItem users;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 235, 227),
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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: [
            
            //Placeholder
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, '/Social');
            }, 
            child: Text('Go back')
            ),

            //SEARCH BAR
            Form(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  
                  Material(
                    color: Colors.transparent,
                    elevation: 10.0,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: 
                            BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 27, 115, 97)),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: Color.fromARGB(255, 27, 115, 97)
                      )
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
              margin: EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 0),
              child: Column(
                children: [
                  Image.asset(
                    users.image,
                  ),

                  Text(users.name)
                ],
              )
              
            )

          ]
          ),
      )
    );
  }
}
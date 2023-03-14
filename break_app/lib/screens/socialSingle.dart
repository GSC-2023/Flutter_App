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
                  SizedBox(height: 10.0),
                  
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

                  //STATISTICS
                  Container(
                    margin: EdgeInsetsDirectional.symmetric(vertical: 20),
                    height: 90,
                    // width: ,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 20,
                      children: <Widget>[
                        // Container(
                        //   // alignment: Alignment.center,
                        //   color: Colors.grey,
                        //   child: Align(
                        //     // alignment: Alignment.center,
                        //     child: Text(
                        //     'TEST',
                        //     textAlign: TextAlign.center,
                            
                        //     ),
                        //   )
                        // ),

                        Container(
                          // alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text('TEST'),
                        ),

                        Container(
                          color: Colors.grey,
                          child: Text(
                            'TEST',
                            textAlign: TextAlign.center,
                            
                            ),
                        ),
                      ],
                      )
                  ),

                 //USER IMAGE
                 Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 5,
                          color: Colors.transparent,
                          ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ],
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage(users.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                
                  //USERNAME
                  Container(
                    margin: EdgeInsetsDirectional.symmetric(vertical: 30),
                    child: Text(
                      users.name,
                      style: TextStyle(
                        fontSize: 20,
                        // fontFamily: 
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),

                  //BUTTONS
                  // Container(
                  //   margin: EdgeInsetsDirectional.symmetric(vertical: 5),
                  //   height: 90,
                  //   child: GridView.count(
                  //     physics: new NeverScrollableScrollPhysics(),
                  //     crossAxisCount: 2,
                  //     mainAxisSpacing: 0,
                  //     crossAxisSpacing: 20,
                  //     children: <Widget>[

                  //       //BUTTON 1
                  //       ElevatedButton(
                  //         onPressed: null, 
                  //         style: ElevatedButton.styleFrom(
                  //           foregroundColor: Colors.purple,
                  //         ),
                  //         child: Text(
                  //           'TEST',
                  //           ),
                          
                  //       ),

                  //       //BUTTON 2
                  //       ElevatedButton(
                  //         onPressed: null, 
                  //         child: Text('TEST'),
                          
                  //         )

        
                  //     ],
                  //     )
                  // ),

                Container(
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: () {}, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            
                          ),
                          child: Text(
                            'TEST',
                            ),
                        ),
                      
                      ElevatedButton(
                          onPressed: () {}, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          child: Text(
                            'TEST',
                            ),
                        ),

                      ]
                    ),
                  ),

                ],
              )
            )
          ]
        ),
      )
    );
  }
}
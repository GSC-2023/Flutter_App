import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:flutter/material.dart';
import './social.dart';


class SocialSingle extends StatelessWidget {
  const SocialSingle({super.key, required this.users});

  final PhotoItem users;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 235, 227),
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
                  margin: EdgeInsetsDirectional.symmetric(vertical: 10),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    
                    //NEED TO MAKE THE NUMBERS DYNAMIC!
                    children: <Widget>[
                      Container(
                        height: 90,
                        width: 150,
                        padding: EdgeInsets.all(10),
                        color: Colors.transparent,
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text(
                              'Breaks Together', 
                              style: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),

                            SizedBox(height: 10,),

                            Text(
                              '5',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold
                                
                              ),
                              )
                          ],
                        ),
                      ),
                      
                      Container(
                        height: 90,
                        width: 150,
                        padding: EdgeInsets.all(10),
                        color: Colors.transparent,
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text(
                              'Streak', 
                              style: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              ),
                            ),

                            SizedBox(height: 10,),

                            Text(
                              '20',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold
                                
                              ),
                              )
                          ],
                        ),
                      ),

                      ]
                    ),
                  ),

                 //USER IMAGE
                 Container(
                      margin: EdgeInsetsDirectional.only(top: 0),
                      height: 300,
                      width: 300,
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
                        borderRadius: BorderRadius.circular(150),
                        image: DecorationImage(
                          image: AssetImage(users.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                
                  //USERNAME
                  Container(
                    margin: EdgeInsetsDirectional.only(top: 15),
                    child: Text(
                      users.name,
                      style: TextStyle(
                        fontSize: 25,
                        // fontFamily: 
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),

                //SOCIAL BUTTONS
                Container(
                  margin: EdgeInsetsDirectional.only(top: 30),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () {}, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 27, 115, 97),
                              shape: StadiumBorder(),
                            ),
                            child: Text(
                              'Message',
                              ),
                          ),
                      ),
                      
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () {}, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 27, 115, 97),
                              shape: StadiumBorder(),
                            ),
                            child: Text(
                              'Remove Friend',
                              ),
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
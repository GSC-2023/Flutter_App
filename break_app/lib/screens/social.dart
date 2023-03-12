import 'package:flutter/material.dart';

class PhotoItem {
  final String image;
  final String name;
  PhotoItem(this.image, this.name);
}


class Social extends StatelessWidget{
  
  final List<PhotoItem> users = [
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Yu Fei'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Ming Han'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Shawn'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'BOB'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
    PhotoItem('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', 'Wayne'),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
        
        title: Text("Meet your friends",
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
            
            //SEARCH BAR
            Form(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  
                  Material(
                    elevation: 14.0,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: 
                            BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(50.0)
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

            //GRID OF FRIENDS
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: GridView.builder(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 20
                ),
              itemCount: users.length,
              itemBuilder: (BuildContext ctx, index) {
              return Container(
                
                child: Column(
                  
                  children: [
                    Container(
                      height: 175,
                      // color: Colors.blue,
                       decoration: BoxDecoration(
                         border: Border.all(
                           width: 4,
                           color: Color.fromARGB(255, 27, 115, 97)

                         ),
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(users[index].image, )
                          ),
                        shape: BoxShape.circle
                      ),
                    ),

                    // Spacer(flex: 1,),

                    Container(
                      margin: EdgeInsets.only(top: 15),
                      // color: Colors.blue,
                      child: Text(users[index].name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 27, 115, 97)),),
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.bottomCenter,
                      )

                  ],
                )

                // color: Colors.blue,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     fit: BoxFit.fitHeight,
                //     image: AssetImage(users[index].image, )
                //     ),
                //   shape: BoxShape.circle
                // ),

            
              );
            }),
            )
          )

            

            // Image.asset('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png',
            //               height: 200,
            //               width: 194),

          ],
        ),

        
        
      )

    );
  }

}
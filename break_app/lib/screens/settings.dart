import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double _currentSliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Settings",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
        ),
        backgroundColor: Color(0xECEAEA),
        shadowColor: Color(0xECEAEA),
        surfaceTintColor: Color(0xECEAEA),
        foregroundColor: Color(0xECEAEA),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(300.0),
                  child: Image.asset(
                      'assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png',
                      height: 200,
                      width: 194)),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text("Wayne Tan",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Slider(
                    value: _currentSliderValue,
                    max: 60,
                    divisions: 60,
                    activeColor: Color(0xff2E593F),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ))
            ]),
      ),
    );
  }
}


// class Settings extends StatefulWidget{
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       drawer: Container(
//         width:200,
//         child: Drawer(
//         child: Column(
//           children: <Widget>[
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: Text('Home'),
//             onTap: (){
//               Navigator.pushNamed(context, '/Home');
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.local_activity_outlined),
//             title: Text('Activities'),
//             onTap: (){
//               Navigator.pushNamed(context, '/Activities');
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.child_care_rounded),
//             title: Text('Social'),
//             onTap: (){
//               Navigator.pushNamed(context, '/Social');
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.bar_chart_outlined),
//             title: Text('Statistics'),
//             onTap: (){
//               Navigator.pushNamed(context, '/Statistics');
//             },
//           ),
//           Expanded(
//             child: Align(
//               alignment: FractionalOffset.bottomCenter,
//               child: ListTile(
//                 dense: true,
//                 visualDensity: VisualDensity(vertical: -4),
//                 leading: Icon(
//                   Icons.settings,
//                 ),
//                 title: Text('Settings'),
//                 onTap: () {
//                   Navigator.pushNamed(context, '/Settings');
//                 },
//               ),
//             ),
//           ),
//           ],
//         ),
//       ),

//       ),
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Text("Settings",
//         style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
//         ),
//         backgroundColor: Color(0xECEAEA),
//         shadowColor: Color(0xECEAEA),
//         surfaceTintColor: Color(0xECEAEA),
//         foregroundColor:  Color(0xECEAEA),
//       ),

//       body: Container(
//         alignment: Alignment.center,
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ClipRRect(borderRadius: BorderRadius.circular(300.0),
//             child: Image.asset('assets/images/Screenshot 2023-02-18 at 12.08.25 PM.png', height:200, width:194)),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: Text("Wayne Tan",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             ),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: Slider(
//                 value: 0,
//                 max: 100,
//                 divisions: 5,
//                 onChanged: (double value) {
//                   setState(() {
//                     _currentSliderValue = value.round();
//                   });
//                 },
//               )
//             )
//           ]
//         ),

        
//       ),
//     );
//   }

// }
import 'package:break_app/screens/activities/physical/components/amenityCard.dart';
import 'package:flutter/material.dart';

class PhysicalRecommendPath extends StatefulWidget {
  @override
  State<PhysicalRecommendPath> createState() => _PhysicalRecommendPathState();
}

class _PhysicalRecommendPathState extends State<PhysicalRecommendPath> {
  Map data = {
    'Yunan Garden': ["park", 3],
    'Nanyang Lake': ["pond", 4],
    'Chinese Heritage Centre': ["heritage", 5]
  };

  @override
  Widget build(BuildContext context) {
    var locations = data.keys.toList();
    for (var location in locations) print(data[location][0]);
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
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Intended Walking Duration: ",
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 30),
                width: double.infinity,
                child: Text(
                  'Generate Amenities',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            data.isEmpty
                ? Text("no data!")
                : Column(
                    children: [
                      Text(
                        "List of Amenities:",
                        style: TextStyle(fontSize: 30),
                      ),
                      for (var location in locations)
                        AmenityCard(
                          name: location,
                          type: (data[location][0]),
                          duration: "${data[location][1]}",
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

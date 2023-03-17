import 'dart:math';

import 'package:break_app/screens/activities/physical/components/amenityCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/google_maps_utils.dart';

class PhysicalRecommendPath extends StatefulWidget {
  @override
  State<PhysicalRecommendPath> createState() => _PhysicalRecommendPathState();
}

class _PhysicalRecommendPathState extends State<PhysicalRecommendPath> {
  
  //Initialised variables for the map
  Position? _currentPosition;
  late GoogleMapController mapController;

  //Create a controller instance for the Google map widget
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //Function to calculate the distance between current location and walk radius
  Point _destinations(point) {
    double distance = 1000;
    double bearing = 10;
    return SphericalUtils.computeOffset(point, distance, bearing);
  }

  Map data = {
    //TODO dynamically render data
    'Yunan Garden': ["park", 3],
    'Nanyang Lake': ["pond", 4],
    'Chinese Heritage Centre': ["heritage", 5]
  };

  @override
  Widget build(BuildContext context) {

    //Fucntion to access user's current location by asking for permission
    _getCurrentLocation() async{
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Geolocator
          .getCurrentPosition()
          .then((Position position) {
            setState(() {
              _currentPosition = position;
            });
          }).catchError((e) {
            print(e);
          });
      }
    
    //controller for tracking user inputs for duration of walk 
    TextEditingController _controller = TextEditingController();
    
    double distance = 0.0;

    void _calculatedWalk(String time) {
      double inputValue = double.parse(time);
      distance = inputValue*0.067056;
    }

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
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.timer_sharp),
                          hintText: 'Walk duration',
                        ),
                        onChanged: (value) => _calculatedWalk(value),
                      ),

                    Text(distance.toString()),
                  ],
                ),

              ),
              
              
              // ElevatedButton(
              //   onPressed: (){}, //TODO logic to calculate route
                
              //   style: ElevatedButton.styleFrom(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30.0),
              //     ),
              //   ),
              //   child: Container(
              //     alignment: Alignment.center,
              //     padding: EdgeInsets.symmetric(vertical: 10),
              //     width: double.infinity,
              //     child: Text(
              //       'Generate Amenities',
              //       style: TextStyle(fontSize: 20),
              //     ),
              //   ),
              // ),
              
              if (_currentPosition != null)...[
                Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentPosition?.latitude ?? 1.362411725249463, _currentPosition?.longitude ?? 103.69650653627447), 
                    zoom: 11.0,
                  ),
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                  },
                ),
              ),] else...[
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Click to load map'),
                )
              ],

              if (_currentPosition != null) Text(
              "LAT: ${_currentPosition!.latitude}, LNG: ${_currentPosition!.longitude}"
              ),

              if (_currentPosition!= null) Text(
                _destinations(Point(_currentPosition!.latitude, _currentPosition!.longitude)).toString()
              ),

              ElevatedButton(
                child: Text("Get location"),
                onPressed: () {
                  _getCurrentLocation();
                },
              ),

              SizedBox(
                height: 20,
              ),
              data.isEmpty
                  ? Text("no data!")
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
    );
  }
}

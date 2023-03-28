
import 'dart:convert';
import 'dart:developer';
import 'package:break_app/models/nearby_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:break_app/screens/activities/physical/components/amenityCard.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

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

  int  count = 1;
  NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse();

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
    final _durationController = TextEditingController();
    
    
    @override
    void dispose() {
      _durationController.dispose();
      super.dispose();
    }

    
    double time = 0 ; //in minutes
    double distance; //in meters
    double latitude = _currentPosition?.latitude ?? 1.362411725249463;
    double longitude = _currentPosition?.longitude ?? 103.69650653627447;
    String apiKey = dotenv.env['API'].toString();

    

    //fxn to calculate the walk distance
    void _calculatedWalk() async{
      await _getCurrentLocation();
      distance = time*80.4672;
      String distance_string = distance.toString();


      var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ',' + longitude.toString() + '&radius=' + distance_string + '&key=' + apiKey);

      var response = await http.post(url);

      inspect(jsonDecode(response.body));

      nearbyPlacesResponse = NearbyPlacesResponse.fromJson(jsonDecode(response.body));

      for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
        print(nearbyPlacesResponse.results![i].name);

      setState(() {
      });

      showModalBottomSheet(
        context: context, 
        builder: (context) {
          return Expanded(
                child: ListView(
                children: [
                  if(nearbyPlacesResponse.results != null)...[
                    for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
                      AmenityCard(
                        name: nearbyPlacesResponse.results![i].name,
                        type: 'park',
                        duration: 4,
                        ),
                      ]
                      else... [
                      AmenityCard(
                        name: 'NO DATA',
                        type: 'park',
                        duration: 4,
                        ),
                      ]
                    ],
                 ),
              );
        }
        );

    }
  
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
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.grey[200],
        elevation: 0,
      ),

      body: 
      
      Container(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              
              Material(
                color: Colors.transparent,
                elevation: 5,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.go,
                    controller: _durationController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(width: 2, color: Colors.white )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(width: 2, color: Colors.white )
                        ),
                      prefixIcon: Icon(Icons.timer_sharp, color: Color.fromARGB(255, 27, 115, 97),),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Walk duration',
                      suffixIcon: Container(
                        // margin: ,
                        child: IconButton(
                          padding: EdgeInsets.only(right: 30, bottom: 35),
                          onPressed: _calculatedWalk,
                          icon: Icon(Icons.arrow_right, size: 60,),
                          color: Color.fromARGB(255, 27, 115, 97),
                          ),
                      )
                    ),
                    onFieldSubmitted: (value) => time = double.parse(value),
                  ),
              ),
              SizedBox(
                height: 20,
              ),
              
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
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                )
              ],

              Text(
                'Walk to a place of interest!', 
                style: TextStyle(fontSize: 25,),
                ),
              
              SizedBox(
                height: 20,
              ),

              // Expanded(
              //   child: ListView(
              //   children: [
              //     if(nearbyPlacesResponse.results != null)...[
              //       for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
              //         AmenityCard(
              //           name: nearbyPlacesResponse.results![i].name,
              //           type: 'park',
              //           duration: 4,
              //           ),
              //         ]
              //         else... [
              //         AmenityCard(
              //           name: 'NO DATA',
              //           type: 'park',
              //           duration: 4,
              //           ),
              //         ]
              //       ],
              //    ),
              // ),
            

              
            ],
            
          ),
        ),
      ),
    );
  }
}

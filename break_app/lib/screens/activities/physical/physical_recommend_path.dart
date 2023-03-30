
import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:break_app/models/nearby_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:break_app/screens/activities/physical/components/amenityCard.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/utils/poly_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:break_app/misc_utils/customDrawer.dart';


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

  @override
  Widget build(BuildContext context) {

    //Fucntion to access user's current location by asking for permission
    Future _getCurrentLocation() async{
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Geolocator
          .getCurrentPosition()
          .then((Position position) {
            setState(() {
              _currentPosition = position;
            });
            // print(_currentPosition);
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
    Set<Polyline> _polylines = Set<Polyline>(); //set collection to hold all the polylines 
    List<LatLng> polylineCoordinates = []; //coordinates making up each polyline
    PolylinePoints polylinePoints; //reference fetches route betwen source and destination

    // @override
    // void initState() {
    //   super.initState();
    //   polylinePoints = PolylinePoints();
    // }

    // void _setPolylines() async {
    //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //     apiKey, 
    //     PointLatLng(latitude, longitude), 
    //     PointLatLng(latitude, longitude)
    //     );

    //     if (result.status == 'OK') {
    //       result.points.forEach((PointLatLng point) {
    //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    //       });

    //       setState(() {
    //         _polylines.add(
    //           Polyline(
    //           width:10 ,
    //           polylineId: PolylineId('polyline'),
    //           color: Colors.black,
    //           points: polylineCoordinates
    //           )
    //         );
    //       });
    //     }
    // }
    //fxn to calculate the walk distance
    void _calculatedWalk() async{
      await _getCurrentLocation();
      distance = time*80.4672;
      String distance_string = distance.toString();
      var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ',' + longitude.toString() + '&radius=' + distance_string + '&key=' + apiKey + '&type=tourist_attraction');
      
      var response = await http.post(url);
      inspect(jsonDecode(response.body));
      NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse.fromJson(jsonDecode(response.body));
      for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
        print(nearbyPlacesResponse.results![i].geometry!.location!.lat);

      setState(() {
      });

      showModalBottomSheet(
        context: context, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        builder: (context) {
          return Expanded(
                child: ListView(
                children: [
                  SizedBox(height: 20,),
                  
                  if(nearbyPlacesResponse.results!.length != 0)...[
                    Text(
                    'Tap for directions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      // fontFamily: ,
                      color: Color(0xff2E593F)
                      ),
                    ),

                    SizedBox(height: 20,),

                    for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
                      AmenityCard(
                        name: nearbyPlacesResponse.results![i].name,
                        type: nearbyPlacesResponse.results![i].icon,
                        duration: time,
                        latDest: nearbyPlacesResponse.results![i].geometry!.location!.lat,
                        lngDest: nearbyPlacesResponse.results![i].geometry!.location!.lng
                        ),
                      ]
                      else... [
                      Text(
                      'Aw, snap!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        // fontFamily: ,
                        color: Color(0xff2E593F)
                        ),
                      ),

                      SizedBox(height: 20,),
                    
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Icon(
                                  Icons.wrong_location_outlined,
                                  size: 120,
                                  color: Color(0xff2E593F)
                                ),
                            
                            SizedBox(height: 10,),

                            Text(
                              'Sorry! We are unable to find any points of interest nearby. Try entering a longer walk duration!',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff2E593F),
                                
                              ),
                              textAlign: TextAlign.center,
                              )
                          ],
                        ),
                      )
                      ]
                    ],
                 ),
              );
        }
        );

    }
  
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Activities",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
        ),
      ),

      body: 
      
      Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled:true,
            polylines: _polylines,
            initialCameraPosition: CameraPosition(
              target: LatLng(_currentPosition?.latitude ?? 1.362411725249463, _currentPosition?.longitude ?? 103.69650653627447), 
              zoom: 11.0,
            ),
            onMapCreated: (GoogleMapController controller) {
                mapController = controller;
            },
          ),

          Positioned(
            top: 20,
            child: Material(
                  color: Colors.transparent,
                  elevation: 5,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width-20,
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
                  ),

                ),
          ),
        ]
      ),
    );
  }
}

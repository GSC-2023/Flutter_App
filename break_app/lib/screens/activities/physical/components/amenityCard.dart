import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class AmenityCard extends StatelessWidget {
  final name;
  final type;
  final duration;
  final lat;
  final lng;
  AmenityCard({required this.name, required this.type, required this.duration, required this.lat, required this.lng});

  void openGmaps() async {
  final String url = 'comgooglemaps://'; 
  final Uri gmapsUrl = Uri.parse(url);
  if (await canLaunchUrl(gmapsUrl)) {
    await launchUrl(gmapsUrl);
  } else {
    // If the app is not installed, launch the website instead
    final String weburl = 'https://www.google.com/maps/@$lat,$lng,13.67z'; //TODO: USE THE NAME OF THE LOCATION AS THE PATH
    final Uri webUri = Uri.parse(weburl);
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri);
    } else {
      throw 'Could not launch $url';
    }
  }
  } 



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shadowColor: Colors.black,
              backgroundColor: Color.fromARGB(255, 27, 115, 97),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {
              openGmaps();
            }, 
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Color.fromARGB(255, 27, 115, 97),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/icons/${type}.png'), //TODO have more categories of amenities for diff icons
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Container(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text('${duration} min'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

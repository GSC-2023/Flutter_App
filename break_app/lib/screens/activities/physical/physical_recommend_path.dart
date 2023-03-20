import 'package:break_app/screens/activities/physical/components/amenityCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:break_app/colors/colors.dart';
import 'package:getwidget/getwidget.dart';



class PhysicalRecommendPath extends StatefulWidget {
  @override
  State<PhysicalRecommendPath> createState() => _PhysicalRecommendPathState();
}

class _PhysicalRecommendPathState extends State<PhysicalRecommendPath> {
  Map data = {
    //TODO dynamically render data
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
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Activities",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
        ),
        backgroundColor: Color(0xECEAEA),
        shadowColor: Color(0xECEAEA),
        surfaceTintColor: Color(0xECEAEA),
        foregroundColor:  Color(0xECEAEA),
      ),
      body: Container(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 5,
                    child: Text(
                      "Intended Walking Duration: ",
                      style: TextStyle(fontSize: 18),
                    ),
                  ), 
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 2,
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Duration',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              // ElevatedButton(
              //   onPressed: () {}, //TODO logic to calculate route
              //   style: ElevatedButton.styleFrom(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30.0),
              //     ),
              //     backgroundColor: DarkGreen,
              //   ),
              //   child: Container(
              //     alignment: Alignment.center,
              //     padding: EdgeInsets.symmetric(vertical: 30),
              //     width: double.infinity,
              //     height: 70,
              //     child: Text(
              //       'Generate Amenities',
              //       style: TextStyle(
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: Offset(10.0, 10.0),
                      blurRadius: 30.0
                    )
                  ]
                ),
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  height: 50,
                  child: GFButton(
                    onPressed: () {},
                    text: "Generate Amenities",
                    textColor: White,
                    shape: GFButtonShape.pills,
                    color: DarkGreen,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
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
                        SizedBox(
                          height: 20,
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

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:url_launcher/url_launcher.dart';


class ChartData {
        ChartData(this.x, this.y, {required this.color});
        final String x;
        final double y;
        final Color color;
}

class Statistics extends StatefulWidget {
  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics>{
  double _currentSliderValue = 5.0;
  final String windDownMessage = "Good evening Wayne, hope you have had a pleasant day today. Your daily mental wellness breaks have played an integral role in keeping your happiness index high. Now, wind down, relax and enjoy your daily wrapped.";
  
  // define any params here
    final List<ChartData> chartData = [
        ChartData('Walk', 5, color : Color.fromARGB(255, 171, 201, 183)),
        ChartData('Rest', 15, color : Color.fromARGB(255, 16, 163, 124)),
        ChartData('Work', 45, color : Color.fromARGB(255, 27, 115, 97)),
    ];

  // insert any helper functions here
  
  void openSpotify() async {
  final String url = 'spotify:playlist:37i9dQZF1E4xkQ7XUTk8SN'; // URI scheme for launching the Spotify app
  final Uri spotifyUri = Uri.parse(url);
  if (await canLaunchUrl(spotifyUri)) {
    await launchUrl(spotifyUri);
  } else {
    // If the app is not installed, launch the website instead
    final String weburl = 'https://open.spotify.com/playlist/37i9dQZF1E4xkQ7XUTk8SN?si=311fc0b393e04c42';
    final Uri webUri = Uri.parse(weburl);
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri);
    } else {
      throw 'Could not launch $url';
    }
  }
  }  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Statistics",
        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
        ),
        backgroundColor: Color(0xECEAEA),
        shadowColor: Color(0xECEAEA),
        surfaceTintColor: Color(0xECEAEA),
        foregroundColor:  Color(0xECEAEA),
      ),
      body: Column( // main column
        children: [ // main column children
          SfCircularChart(
            margin: EdgeInsets.symmetric(vertical:8, horizontal: 12.0),
            legend: Legend(isVisible: true, position: LegendPosition.bottom, isResponsive: true, textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper:(ChartData data, _) => data.y,
 
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside),
              )
            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 40, 10, 10),
          child: Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  children: [
                    Text("Work to break",
                      style: TextStyle(fontSize : 20.0, fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical:10.0),
                    child:Text("4.2",
                      style: TextStyle(fontSize : 32.0, fontWeight: FontWeight.w900, color: Color(0xff2E593F)),
                    ), ),
                  ],
                )
              ),
              Container(
                child: Column(
                  children: [
                    Text("Happiness Index",
                      style: TextStyle(fontSize : 20.0, fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical:10.0),
                    child:Text("8.0",
                      style: TextStyle(fontSize : 32.0, fontWeight: FontWeight.w900, color: Color(0xff2E593F)),
                    ), ),
                  ],
                )
              )
          ],)),

          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:EdgeInsets.all(25),
              child:Column(
                children: [
                  Text("How happy are you today?",
              style: TextStyle(fontSize : 15.0, fontWeight: FontWeight.bold, color: Color(0xff2E593F)),),
              Column(children: [
                SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Color(0xff2E593F),
                inactiveTrackColor: Color(0xff2E593F).withOpacity(0.5),
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 10.0,
                thumbColor: Colors.blueAccent,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              ),

              child: Slider(
              value: _currentSliderValue,
              max: 10,
              divisions: 10.toInt(),
              activeColor: Color(0xff2E593F),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            )

            ),

              ],),
            Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
              child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              Text("0"),
              Text("10")
            ],)),
            
                ]
              )
            )
            ),

        
        Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height : 100,
          width : 4000,
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Padding(padding: EdgeInsets.all(15.0),
                  child: Text(windDownMessage, 
                  style: TextStyle(fontSize: 13.0),)
          )
        )),

        Padding(padding:EdgeInsets.all(25),
        child: Container(
          alignment: Alignment.center,
          child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xff2E593F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          fixedSize: const Size(350,30),
        ),
        onPressed: (){
          // send happines scale to db for backend analysis
          // pop up to open spotify for calming tracks
          openSpotify();
          // Navigator.pushNamed(context, "/Home");
          }, 
          child: Text("Wind Down")),
        )
        )
        
        
          
        

        
        
        
        ], // main column children
      ) // main column

    );
  }

  // hello test hello

}
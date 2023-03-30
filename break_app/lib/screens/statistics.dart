import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:break_app/misc_utils/customDrawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:break_app/models/profile.dart';
import 'package:break_app/models/breakUser.dart';
import 'package:break_app/firebase/database.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

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

class _StatisticsState extends State<Statistics> {
  double _currentSliderValue = 8.0;
  double _walk = 5.0;
  double _rest = 5.0;
  double _work = 45.0;

  String _windDownMessage = "";
  late profile user;
  late breakUser bu;
  // late String dateStr;

  //String dateStr = DateFormat('ddMMyy').format(DateTime.now());
  String dateStr = "230323";

  Future<void> getBreakUser(user) async {
    bu = await DatabaseService().getUser(user.uid);
    Map<String, dynamic> windDownMessages =
        await DatabaseService().getWindDownMessages();

    Map<String, dynamic> dailyStats = bu.dailyStats;

    var rng = Random();
    int randint = rng.nextInt(10);
    if (randint == 0) {
      randint++;
    }
    ;

    setState(() {
      chartData = [
        ChartData('Walk', dailyStats[dateStr][2].toDouble(),
            color: Color.fromARGB(255, 171, 201, 183)),
        ChartData('Rest', dailyStats[dateStr][1].toDouble(),
            color: Color.fromARGB(255, 16, 163, 124)),
        ChartData('Work', dailyStats[dateStr][0].toDouble(),
            color: Color.fromARGB(255, 27, 115, 97)),
      ];
      _work = dailyStats[dateStr][0].toDouble();
      _rest = dailyStats[dateStr][1].toDouble();
      _walk = dailyStats[dateStr][2].toDouble();
      _windDownMessage = windDownMessages[randint.toString()];
    });
  }

  // define any params here
  List<ChartData> chartData = [
    ChartData('Walk', 0, color: Color.fromARGB(255, 171, 201, 183)),
    ChartData('Rest', 0, color: Color.fromARGB(255, 16, 163, 124)),
    ChartData('Work', 0, color: Color.fromARGB(255, 27, 115, 97)),
  ];

  // insert any helper functions here

  void openSpotify() async {
    final String url =
        'spotify:playlist:37i9dQZF1E4xkQ7XUTk8SN'; // URI scheme for launching the Spotify app
    final Uri spotifyUri = Uri.parse(url);
    if (await canLaunchUrl(spotifyUri)) {
      await launchUrl(spotifyUri);
    } else {
      // If the app is not installed, launch the website instead
      final String weburl =
          'https://open.spotify.com/playlist/37i9dQZF1E4xkQ7XUTk8SN?si=311fc0b393e04c42';
      final Uri webUri = Uri.parse(weburl);
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Timestamp) {
      user = Provider.of<profile>(context, listen: false);
      getBreakUser(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Statistics",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
          ),
          backgroundColor: Color(0xECEAEA),
          shadowColor: Color(0xECEAEA),
          surfaceTintColor: Color(0xECEAEA),
          foregroundColor: Color(0xECEAEA),
        ),
        body: Column(
          // main column
          children: [
            // main column children
            SfCircularChart(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  isResponsive: true,
                  textStyle:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
              series: <CircularSeries>[
                DoughnutSeries<ChartData, String>(
                  dataSource: chartData,
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        Text(
                          "Work to break",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2E593F)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            (_work / (_rest + _walk)).toStringAsPrecision(3),
                            style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff2E593F)),
                          ),
                        ),
                      ],
                    )),
                    Container(
                        child: Column(
                      children: [
                        Text(
                          "Happiness Index",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2E593F)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            _currentSliderValue.toString(),
                            style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff2E593F)),
                          ),
                        ),
                      ],
                    ))
                  ],
                )),

            Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(children: [
                      Text(
                        "How happy are you today?",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2E593F)),
                      ),
                      Column(
                        children: [
                          SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Color(0xff2E593F),
                                inactiveTrackColor:
                                    Color(0xff2E593F).withOpacity(0.5),
                                trackShape: RoundedRectSliderTrackShape(),
                                trackHeight: 10.0,
                                thumbColor: Colors.blueAccent,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                overlayColor: Colors.red.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
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
                              )),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("0"), Text("10")],
                          )),
                    ]))),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                    height: 130,
                    width: 4000,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          _windDownMessage,
                          style: TextStyle(fontSize: 13.0),
                        )))),

            Padding(
                padding: EdgeInsets.all(25),
                child: Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff2E593F),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: const Size(350, 30),
                      ),
                      onPressed: () async {
                        // send happines scale to db for backend analysis
                        bu.dailyStats[dateStr][3] = _currentSliderValue;
                        await DatabaseService().updateUser(bu, user.uid);
                        // pop up to open spotify for calming tracks
                        openSpotify();
                        // Navigator.pushNamed(context, "/Home");
                      },
                      child: Text("Wind Down")),
                ))
          ], // main column children
        ) // main column

        );
  }

  // hello test hello
}

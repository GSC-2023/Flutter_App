import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


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
  
  // define any params here
    final List<ChartData> chartData = [
        ChartData('Walk', 5, color : Color.fromARGB(255, 171, 201, 183)),
        ChartData('Rest', 15, color : Color.fromARGB(255, 16, 163, 124)),
        ChartData('Work', 45, color : Color.fromARGB(255, 27, 115, 97)),
    ];

  @override

  // insert any helper functions here








  Widget build(BuildContext context){
    return Scaffold(
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
        title: Text("Statistics",
        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2E593F)),
        ),
        backgroundColor: Color(0xECEAEA),
        shadowColor: Color(0xECEAEA),
        surfaceTintColor: Color(0xECEAEA),
        foregroundColor:  Color(0xECEAEA),
      ),
      body: Column(
        children: [
          SfCircularChart(
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
          )
        ],
      )

    );
  }

  // hello test hello

}
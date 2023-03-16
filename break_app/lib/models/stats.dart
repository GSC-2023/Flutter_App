import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class breakUser {
  String name;
  int workTime;
  int restTime;
  int cycleTime;
  int lunchTime;
  int dinnerTime;
  List<dynamic> happinessIndex;
  Map<String, dynamic> meetups; //name: [dates]
  Map<String, dynamic> dailyStats; //daily: work, rest, walk
  String imageurl;

  breakUser({
    required this.name,
    required this.workTime,
    required this.restTime,
    required this.cycleTime,
    required this.lunchTime,
    required this.dinnerTime,
    required this.happinessIndex,
    required this.meetups,
    required this.dailyStats,
    required this.imageurl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'workTime': workTime,
      'restTime': restTime,
      'cycleTime': cycleTime,
      'lunchTime': lunchTime,
      'dinnerTime': dinnerTime,
      'happinessIndex': happinessIndex,
      'meetups': meetups,
      'dailyStats': dailyStats,
      'imageurl': imageurl
    };
  }

  void addDailyStatsNow(work, rest, walk) {
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('ddMMyy');
    String formattedDate = formatter.format(now);
    dailyStats[formattedDate] = [work, rest, walk];
  }
}

// void addMeetupNow(name) {  //TODO- update friends record & error code
//   DateTime now = new DateTime.now();
//   var formatter = new DateFormat('ddMMyy');
//   String formattedDate = formatter.format(now);
//   if (meetups.containsKey(name)) {
//     meetups[name].add(formattedDate);
//   } else {
//     meetups[name] = [formattedDate];
//   }
// }

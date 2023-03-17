import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../firebase/database.dart';

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
    this.dailyStats[formattedDate] = [work, rest, walk];
  }

  Future<bool> addMeetupNow(friendName, myUid) async {
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('ddMMyy');
    String formattedDate = formatter.format(now);
    if (addMeetupNowFriend(friendName, formattedDate) == false) {
      return false;
    }
    if (this.meetups.containsKey(friendName)) {
      this.meetups[friendName].add(formattedDate);
    } else {
      this.meetups[friendName] = [formattedDate];
    }
    await DatabaseService().updateUser(this, myUid);
    return true;
  }

  Future<bool> addMeetupNowFriend(friendName, formattedDate) async {
    var friendUID = await DatabaseService().getUidWithName(friendName);
    var friendUser = await DatabaseService().getUserWithName(friendName);
    if (friendUID == null || friendUser == null) {
      return false;
    }
    if (friendUser.meetups.containsKey(this.name)) {
      friendUser.meetups[this.name].add(formattedDate);
    } else {
      friendUser.meetups[this.name] = [formattedDate];
    }
    await DatabaseService().updateUser(friendUser, friendUID);
    return true;
  }
}

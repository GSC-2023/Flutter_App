import 'dart:developer';
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
  bool onBreak;

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
    required this.onBreak,
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
      'imageurl': imageurl,
      'onBreak': onBreak,
    };
  }

  void addDailyStatsNow(work, rest, walk) {
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('ddMMyy');
    String formattedDate = formatter.format(now);
    this.dailyStats[formattedDate] = [work, rest, walk];
  }

  Future<bool> addFriends(friendName) async {
    //test
    var friendUser = await DatabaseService().getUserWithName(friendName);
    if (friendUser == null) {
      return false; //no such user
    }
    _addUserFriends(this, friendUser);
    if (this.meetups.containsKey(friendName)) {
      return true; //already added friend
    } else {
      this.meetups[friendName] = [];
      return true;
    }
  }

  Future<bool> _addUserFriends(user, friend) async {
    if (friend.meetups.containsKey(user.name)) {
      return true; //already added friend
    } else {
      friend.meetups[user.name] = [];
      return true;
    }
  }

  Future<bool> addMeetupNow(friendName, myUid) async {
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('ddMMyy');
    String formattedDate = formatter.format(now);
    if (_addMeetupNowFriend(friendName, formattedDate) == false) {
      return false; //no such user
    }
    if (this.meetups.containsKey(friendName)) {
      this.meetups[friendName].add(formattedDate);
    } else {
      return false; //not a friend
    }
    await DatabaseService().updateUser(this, myUid);
    return true;
  }

  Future<bool> _addMeetupNowFriend(friendName, formattedDate) async {
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

  Future<bool> changeBreakStatus(status) async {
    //to be called when on and off
    onBreak = status;
    return onBreak;
  }
}

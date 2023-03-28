import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:scidart/numdart.dart';
import '../firebase/database.dart';

class breakUser {
  String name;
  int workTime;
  int restTime;
  int cycleTime;
  int lunchTime;
  int dinnerTime;
  Map<String, dynamic> meetups; //name: [dates]
  Map<String, dynamic> dailyStats; //daily: work, rest, walk, happinessIndex
  String imageurl;
  bool onBreak;

  breakUser({
    required this.name,
    required this.workTime,
    required this.restTime,
    required this.cycleTime,
    required this.lunchTime,
    required this.dinnerTime,
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
      'meetups': meetups,
      'dailyStats': dailyStats,
      'imageurl': imageurl,
      'onBreak': onBreak,
    };
  }

  void addDailyStatsNow(work, rest, walk, happiness) {
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('ddMMyy');
    String formattedDate = formatter.format(now);
    this.dailyStats[formattedDate] = [work, rest, walk, happiness];
  }

  Future<bool> removeFriend(friendName) async {
    var friendUser = await DatabaseService().getUserWithName(friendName);
    if (friendUser == null) {
      return false; //no such user
    }
    friendUser.meetups.remove(this.name);
    this.meetups.remove(friendName);
    return true;
  }

  Future<bool> addFriends(friendName) async {
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

  void _addUserFriends(user, friend) {
    if (friend.meetups.containsKey(user.name)) {
      return; //already added friend
    } else {
      friend.meetups[user.name] = [];
      return;
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

  double workRestRatioRecommender() {
    PolyFit best = polynomialDegreeRecommender();
    print(best.coefficients());
    print(best.polyDegree());
    var ratio = (-best.coefficient(1) / 2 * best.coefficient(0));
    print(ratio);
    return ratio;
  }

  PolyFit polynomialDegreeRecommender() {
    List variables = [];
    List happinessIndex = [];
    dailyStats.values.forEach((e) {
      var work = e[0];
      var rest = e[1];
      var ratio = work / (work + rest);
      variables.add(ratio);
      var happiness = e[3] + .0;
      happinessIndex.add(happiness);
    });
    var degrees = [1, 2, 3, 4, 5];
    var bestR2value = 1.0;
    late PolyFit best;
    for (var degree in degrees) {
      var current = PolyFit(Array(variables.cast<double>()),
          Array(happinessIndex.cast<double>()), degree);
      inspect(current.R2());
      if (current.R2() < bestR2value) {
        bestR2value = current.R2();
        best = current;
      }
    }
    return best;
  }
}

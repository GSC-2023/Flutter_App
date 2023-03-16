class breakUser {
  String name;
  int workTime;
  int restTime;
  int cycleTime;
  int lunchTime;
  int dinnerTime;
  List<dynamic> happinessIndex;
  Map<String, dynamic> meetups; //name: count
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
}

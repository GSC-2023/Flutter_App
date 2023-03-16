class breakUser {
  String name;
  String imageURL;
  int restTime;
  breakUser(
      {required this.name, required this.imageURL, required this.restTime});
  Map<String, dynamic> toMap() {
    return {'name': name, 'imageurl': imageURL, 'restTime': restTime};
  }
}

class breakUser {
  String name;
  String imageURL;
  int restTime; //TODO add full fields
  breakUser(
      {required this.name,
      required this.imageURL,
      required this.restTime}); //TODO add full fields
  Map<String, dynamic> toMap() {
    //TODO add full fields
    return {'name': name, 'imageurl': imageURL, 'restTime': restTime};
  }
}

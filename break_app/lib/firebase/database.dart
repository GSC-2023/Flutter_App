import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:break_app/models/user.dart';
import 'dart:developer';

class DatabaseService {
  final String uid = 'timmy';

  DatabaseService();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<breakUser> getUser() async {
    var profile;
    await usersCollection.doc(uid).get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      profile = new breakUser(
          name: data['name'],
          restTime: data['restTime'],
          imageURL: data['imageurl']);
    });
    return profile;
  }

  Future updateUser(profile) async {
    inspect(profile);
    return await usersCollection.doc(uid).update(profile.toMap());
  }
}

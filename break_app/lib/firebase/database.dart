import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:break_app/models/stats.dart';

class DatabaseService {
  final String uid;

//TODO streak A B num of times table
//TODO cumulative rests, work and walk in a day
  DatabaseService({required this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<breakUser> getUser() async {
    var user;
    await usersCollection.doc(uid).get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      //inspect(data);
      //print(data['meetups'].runtimeType);
      //print(data['dailyStats'].runtimeType);
      user = new breakUser(
          name: data['name'],
          workTime: data['workTime'],
          restTime: data['restTime'],
          cycleTime: data['cycleTime'],
          lunchTime: data['lunchTime'],
          dinnerTime: data['dinnerTime'],
          happinessIndex: data['happinessIndex'],
          meetups: data['meetups'],
          dailyStats: data['dailyStats'],
          imageurl: data['imageurl']);
    });
    return user;
  }

  Future createUser(name) async {
    var user = new breakUser(
        name: name,
        workTime: 1,
        restTime: 2,
        cycleTime: 3,
        lunchTime: 1200,
        dinnerTime: 1400,
        happinessIndex: [1, 2, 3, 4, 5],
        meetups: {'tommy': 1, 'timmy': 2, 'sammy': 3},
        dailyStats: {
          '170323': [1, 2, 3],
          '180323': [4, 5, 7],
          '190323': [2, 8, 9]
        }, //daily: work, rest, walk
        imageurl: 'imageurl');
    return await usersCollection.doc(uid).set(user.toMap());
  }

  Future updateUser(user) async {
    return await usersCollection.doc(uid).update(user.toMap());
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:break_app/models/breakUser.dart';

class DatabaseService {
  DatabaseService();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference windDownMessagesCollection =
      FirebaseFirestore.instance.collection('windDownMessages');

  Future<Map<String, dynamic>> getWindDownMessages() async {
    var dataout;
    await windDownMessagesCollection
        .doc("TN4RkOxNNCuYDKwmkR2n")
        .get()
        .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      // print(data);
      // inspect(data);
      dataout = data;
    });
    // print(dataout);
    return dataout;
  }

  Future<List<dynamic>> getOnBreakUsers(name) async {
    var users = [];
    var userJSON;
    var user;
    await usersCollection
        .where("name", isNotEqualTo: name)
        .where("onBreak", isEqualTo: true)
        .get()
        .then(
      (QuerySnapshot) {
        final data = QuerySnapshot.docs;
        for (var i = 0; i < data.length; i++) {
          userJSON = data[i].data();
          user = jsonToObject(userJSON);
          users.add(user);
        }
      },
      onError: (e) => print('Error in query: $e'),
    );
    return users;
  }

  Future<String?> getUidWithName(name) async {
    var uid;
    await usersCollection.where('name', isEqualTo: name).get().then(
      (QuerySnapshot) {
        final data = QuerySnapshot.docs; //takes the first match
        try {
          uid = data[0].id;
        } catch (e) {
          print('getUidWithName Error in indexing: $e');
          return null;
        }
      },
      onError: (e) => print('Error in query: $e'),
    );
    inspect(uid);
    return uid;
  }

  Future<breakUser?> getUserWithName(name) async {
    var userJSON;
    var user;
    await usersCollection.where('name', isEqualTo: name).get().then(
      (QuerySnapshot) {
        final data = QuerySnapshot.docs; //takes the first match
        try {
          userJSON = data[0].data();
          user = jsonToObject(userJSON);
        } catch (e) {
          print('getUserWithName Error in indexing: $e');
          return null;
        }
      },
      onError: (e) => print('Error in query: $e'),
    );
    //inspect(user);
    return user;
  }

  Future<breakUser> getUser(uid) async {
    var user;
    await usersCollection.doc(uid).get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      //inspect(data);
      //print(data['meetups'].runtimeType);
      //print(data['dailyStats'].runtimeType);
      user = jsonToObject(data);
    });
    return user;
  }

  breakUser jsonToObject(data) {
    breakUser user = new breakUser(
      name: data['name'],
      workTime: data['workTime'],
      restTime: data['restTime'],
      cycleTime: data['cycleTime'],
      lunchTime: data['lunchTime'],
      dinnerTime: data['dinnerTime'],
      meetups: data['meetups'], //{name: [dates]}
      dailyStats: data['dailyStats'], //{day:[work,rest,walk, happiness]}
      imageurl: data['imageurl'],
      onBreak: data['onBreak'],
    );
    return user;
  }

  Future createUser(name, uid) async {
    var user = new breakUser(
      //default user values
      name: name,
      workTime: 45,
      restTime: 15,
      cycleTime: 60,
      lunchTime: 1200,
      dinnerTime: 1800,
      meetups: {},
      dailyStats: {}, //daily: work, rest, walk
      imageurl: 'imageurl',
      onBreak: true,
    );
    return await usersCollection.doc(uid).set(user.toMap());
  }

  Future updateUser(breakUser user, String uid) async {
    return await usersCollection.doc(uid).update(user.toMap());
  }
}

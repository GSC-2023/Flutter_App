import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:break_app/models/stats.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<breakUser> getUser() async {
    var user;
    await usersCollection.doc(uid).get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      user = new breakUser(
          name: data['name'],
          restTime: data['restTime'],
          imageURL: data['imageurl']);
    });
    return user;
  }

  Future createUser(name) async {
    var user = new breakUser(
        name: name,
        imageURL: 'imageURL',
        restTime: 10000); //TODO replace with default values
    return await usersCollection.doc(uid).set(user.toMap());
  }

  Future updateUser(user) async {
    return await usersCollection.doc(uid).update(user.toMap());
  }
}

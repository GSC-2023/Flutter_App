import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
import 'package:break_app/models/profile.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  profile? _userFromFireBaseUser(User? user) {
    return user != null
        ? profile(name: user.email!.split('@')[0], uid: user.uid)
        : null;
  }

  Future signIn(String username, String password) async {
    try {
      String email = username + '@gmail.com';
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid);
      return _userFromFireBaseUser(user);
    } catch (e) {
      print('oh no');
      print(e.toString());
      return null;
    }
  }

  Future register(String username, String password) async {
    try {
      String email = username + '@gmail.com';
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      await DatabaseService(uid: user.uid)
          .createUser(user.email!.split('@')[0]);
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      print('signing out');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

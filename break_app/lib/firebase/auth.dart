import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
import 'package:break_app/models/profile.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  profile? _userFromFireBaseUser(User? user) {
    user != null ? print("welcome " + user.email!.split('@')[0]) : print('nth');
    return user != null
        ? profile(name: user.email!.split('@')[0], uid: user.uid, userWorkMinutesElapsed: 0, userBreakMinutesElapsed: 0)
        : null;
  }

  Stream<profile?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFireBaseUser(user));
  }

  Future signIn(String username, String password) async {
    try {
      String email = username + '@gmail.com';
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      //create a new document for the user with the uid
      await DatabaseService(); //TODO seems useless
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
      await DatabaseService().createUser(user.email!.split('@')[0], user.uid);
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return 0;
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

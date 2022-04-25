import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // register with email and pass
  Future registerWithEmailAndPassword(String e, String p) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: e,
        password: p,
      );
      userCredential.user!.sendEmailVerification();
      return userCredential.user!;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // sign in with email and pass
  Future signInWIthEmailAndPassword(String e, String p) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: e, password: p);
      return userCredential.user!;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

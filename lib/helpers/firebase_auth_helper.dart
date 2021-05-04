import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthHelper {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> registerUser(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on Exception catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<UserCredential> loginUser(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on Exception catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> passwordRecovery(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on Exception catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> logOutUser() async {
    try {
      await _auth.signOut();
    } on Exception catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<UserCredential> changePassword(String password) async {
    try {
      String email = _auth.currentUser!.email.toString();
      await _auth.currentUser!.updatePassword(password);
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      var result = await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}

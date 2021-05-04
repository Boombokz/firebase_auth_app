import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginHelper {
  Future<UserCredential?> signInWithFacebook() async {
    try{
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token);
        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
      return null;
    } catch (e,s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
    }

  }
}
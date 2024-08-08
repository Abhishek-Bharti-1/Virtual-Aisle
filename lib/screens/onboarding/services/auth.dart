import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<int> signInWithGoogle() async {
    int res = 1;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      final GoogleSignInAuthentication? googleSignInAuth = await googleSignInAccount
          ?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth?.accessToken,
          idToken: googleSignInAuth?.idToken
      );

      UserCredential userCredential = await _auth
          .signInWithCredential(credential);

      //print("$userCredential");
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          res += 1;
          // await _firestore.collection('Users').doc(user.uid).set({
          //   'userName': user.displayName,
          // });
        }
        res += 1;
      }
    } catch (e) {
      print(e);
      res = 0;
    }
    return res;
  }

}
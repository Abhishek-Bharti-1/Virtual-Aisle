import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return 0; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot userDoc = await _firestore.collection('Users').doc(user.uid).get();

        if (!userDoc.exists) {
          // User document does not exist in Firestore
          return 3; // New user, move to InfoForm screen
        } else {
          final data = userDoc.data() as Map<String, dynamic>;
          bool profCreated = data['isProfileCreated'] ?? false;
          bool isPrefSelected = data['isPrefSelected'] ?? false;

          if (profCreated && isPrefSelected) {
            return 1; // Move to HomeScreen
          } else if (profCreated && !isPrefSelected) {
            return 2; // Move to PreferenceScreen
          } else {
            return 3; // Move to InfoForm screen
          }
        }
      }

      return 0; // Failed to sign in
    } catch (e) {
      print(e);
      return 0; // Sign-in failed
    }
  }

  Future<int> checkUserStatus() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        print("User not found");
        return 0; // User is not signed in
      }

      final DocumentSnapshot userDoc = await _firestore.collection('Users').doc(user.uid).get();

      if (!userDoc.exists) {
        return 3; // New user, move to InfoForm screen
      } else {
        final data = userDoc.data() as Map<String, dynamic>;
        bool profCreated = data['isProfileCreated'] ?? false;
        bool isPrefSelected = data['isPrefSelected'] ?? false;

        if (profCreated && isPrefSelected) {
          return 1; // Move to HomeScreen
        } else if (profCreated && !isPrefSelected) {
          return 2; // Move to PreferenceScreen
        } else {
          return 3; // Move to InfoForm screen
        }
      }
    } catch (e) {
      print(e);
      return 0; // Error or not signed in
    }
  }
}

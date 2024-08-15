import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/User.dart';


class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Create a new question
  Future<void> addUsers(Users users) async {
    await _firestore.collection('Users').doc(users.uid).set(users.toJson());
  }

  // // Get all questions
  Stream<List<Users>> getUsersInfo() {
    return _firestore.collection('Users').snapshots().map(
          (snapshot) {
        return snapshot.docs.map(
              (doc) {
            return Users.fromJson(doc.data() as Map<String, dynamic>);
          },
        ).toList();
      },
    );
  }


  DocumentSnapshot<Map<String, dynamic>>? getUsersData()  {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> UsersSnapshot =
         FirebaseFirestore.instance.collection('Users').doc(uid).get() as DocumentSnapshot<Map<String, dynamic>>;

        // Check if the Users document exists
        if (UsersSnapshot.exists) {
          // Access the 'name' field from the Users document
          String? UsersName = UsersSnapshot.get('name');
          return UsersSnapshot;
        } else {
          // Users document does not exist
          return null;
        }
      } catch (e) {
        print("Error fetching Users name: $e");
        return null;
      }
    } else {
      // Users is not authenticated
      return null;
    }
  }







  Future<String?> uploadImage(File image, String uid) async {
    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      Reference ref = _storage.ref().child('user_images/$uid.jpg');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = ref.putFile(image);

      // Get the download URL once the upload is complete
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

Future<void> updateUserPreferences(String uid, Map<String, dynamic> preferences) async {
  try {
    // Update the user's document with the provided preferences
    await _firestore.collection('Users').doc(uid).update(preferences);
  } catch (e) {
    print("Error updating user preferences: $e");
  }
}

}

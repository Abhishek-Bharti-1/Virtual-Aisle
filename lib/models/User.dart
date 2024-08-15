import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {

  final String? uid;
  final String userName;
  final String userGender;
  final String userAddress;
  final String userState;
  final String userPin;
  final String userDob;
  final String imageUrl;
  final bool isProfileCreated;

  Users({
    required this.uid,
    required this.userName,
    required this.userGender,
    required this.userAddress,
    required this.userState,
    required this.userPin,
    required this.userDob,
    required this.imageUrl,
    required this.isProfileCreated,

  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uid: json['uid'],
      userName: json['userName'],
      userGender: json['userGender'],
      userAddress: json['userAddress'],
      userDob: json['userDob'],
      userPin: json['userPin']??" ",
      userState: json['userState'],
      imageUrl: json['imageUrl']??" ",
      isProfileCreated: json['isProfileCreated']??" ",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      "userGender": userGender,
      'userAddress': userAddress,
      'userState': userState,
      'userPin': userPin,
      'userDob':userDob,
      'imageUrl':imageUrl,
      'isProfileCreated':isProfileCreated,
    };
  }
  factory Users.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Users(

        uid:data['uid'],
        userName: data['userName'],
        userGender: data['userGender'],
        userAddress: data['facultyHomeAddress'],
        userState: data['facultyDeptAddress'],
        userPin: data['phoneNo'],
        userDob: data['userDob'],
        imageUrl: data['imageUrl'],
        isProfileCreated: data['isProfileCreated']
      // Add any other properties as needed
    );
  }
}

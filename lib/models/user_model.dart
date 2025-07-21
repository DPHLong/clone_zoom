import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String bio;
  final String profileImage;
  final List contacts;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.bio,
    required this.profileImage,
    required this.contacts,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'username': username,
    'email': email,
    'bio': bio,
    'profileImage': profileImage,
    'contacts': contacts,
  };

  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'],
      username: data['username'],
      email: data['email'],
      bio: data['bio'],
      profileImage: data['profileImage'],
      contacts: data['contacts'],
    );
  }
}

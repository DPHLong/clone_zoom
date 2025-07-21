import 'package:clone_zoom/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class FirebaseMethods {
  Future<void> addToMeetingHistory(String meetingName, String meetingId) async {
    /*We can later set Meeting as a Model with more properties such as List of
    * paticipants, moderator, ... But for now I just make it simple. */

    try {
      await firestore
          .collection('zoom_users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('meetings')
          .doc(meetingId)
          .set({
            'meetingId': meetingId,
            'meetingName': meetingName,
            'createdAt': DateTime.now(),
          });
    } catch (e) {
      debugPrint('--- Error by adding meeting to history: $e ---');
    }
  }

  Future<String> uploadImageToStorage(
    Uint8List image,
    String folder,
    String imageId,
  ) async {
    try {
      final Reference ref = firebaseStorage.ref().child(folder).child(imageId);
      final UploadTask uploadTask = ref.putData(image);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      debugPrint('--- Error by uploading image to storage: $e ---');
      return '';
    }
  }

  Future<UserModel> getUserDetails(String uid) async {
    final snapshot = await firestore.collection('zoom_users').doc(uid).get();
    return UserModel.fromSnap(snapshot);
  }
}

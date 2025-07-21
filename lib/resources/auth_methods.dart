import 'package:clone_zoom/models/user_model.dart';
import 'package:clone_zoom/resources/firebase_methods.dart';
import 'package:clone_zoom/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn.instance;

class AuthMethods {
  Stream<User?> get authChanges => firebaseAuth.authStateChanges();
  User get user => firebaseAuth.currentUser!;
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  /// * in recent versions of the google_sign_in package (like 7.1.0),
  /// * the signIn() method has been replaced by the authenticate() method.
  /// * Similarly, the GoogleAuthProvider.credential() method no longer accepts
  /// * accessToken — it now only uses the ID token.
  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );

      debugPrint('--- user credential $userCredential ---');

      User? user = userCredential.user;

      if (user != null) {
        // check whether user is new. If yes, add to firestore
        if (userCredential.additionalUserInfo!.isNewUser) {
          firestore.collection('zoom_users').doc(user.uid).set({
            'uid': user.uid,
            'username': user.displayName,
            'email': user.email,
            'bio': '',
            'profileImage': user.photoURL,
            'contacts': [],
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('--- Error by signing in with google: $e ---');
      showSnackbar(context, '${e.message}');
      res = false;
    }
    return res;
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<bool> signUpUser({
    required String username,
    required String email,
    required String password,
    String? bio,
    Uint8List? profileImage,
  }) async {
    bool res = false;
    try {
      String imageUrl = '';
      final cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (profileImage != null) {
        // upload image to firestore
        imageUrl = await _firebaseMethods.uploadImageToStorage(
          profileImage,
          'profile_images',
          cred.user!.uid,
        );
        // create user Doc on firestore
        UserModel userModel = UserModel(
          uid: cred.user!.uid,
          username: username,
          email: email,
          bio: bio ?? '',
          profileImage: imageUrl,
          contacts: [],
        );
        await firestore
            .collection('zoom_users')
            .doc(cred.user!.uid)
            .set(userModel.toJson());
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('--- Error by signing in with google: $e ---');
      res = false;
    }
    return res;
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    bool res = false;
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('--- Error by signing in with google: $e ---');
      res = false;
    }
    return res;
  }

  Future<bool> signOutUser() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } on Exception catch (e) {
      debugPrint('--- Error by signing out: $e ---');
      return false;
    }
  }
}

import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // sign up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String bio,
    required String userName,
    required Uint8List file,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              bio.isNotEmpty ||
              userName.isNotEmpty
          //  ||
          // file != null
          ) {
        // Regsiter User
        UserCredential crud = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        /*
        _firestore.collection("users").doc(crud.user!.uid).set({
          "username": userName,
          "uid": crud.user!.uid,
          "email": email,
          "bio": bio,
          "followers": [],
          "followings": []
        });*/
        String photoUrl = await StorageMethods().uploadImagetoStorage(
            childName: "profilePics", file: file, isPost: false);

        _firestore.collection("users").add({
          "username": userName,
          "uid": crud.user!.uid,
          "email": email,
          "bio": bio,
          "followers": [],
          "followings": [],
          "photoUrl": photoUrl
        });

        res = 'success';
        log(crud.user!.uid);
        log(res.toString());
      }
    } on FirebaseException catch (err) {
      res = err.message.toString();
      log(res);
      return res;
    } catch (e) {
      res = e.toString();

      log(res.toString());

      return res;
    }
    return res;
  }
}

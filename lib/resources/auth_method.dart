import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/storage_method.dart';
import 'package:instagram_clone/screens/login_screen.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User user = _auth.currentUser!;
    DocumentSnapshot userData =
        await _firestore.collection('users').doc(user.uid).get();
    return model.User.userFromSnap(userData);
  }

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
          userName.isNotEmpty) {
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

        model.User user = model.User(
          bio: bio,
          email: email,
          followings: [],
          uid: crud.user!.uid,
          username: userName,
          photoUrl: photoUrl,
          folowers: [],
        );

        _firestore.collection("users").doc(crud.user!.uid).set(user.toJson());

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

  Future<String> login(String email, String password) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
        log("login $res");
      }
    } catch (e) {
      res = e.toString();
      log("Error$res");
    }
    log("exception: $res");
    return res;
  }
  // Sign out function 
  Future<void> signOut(BuildContext? context)async{
       await _auth.signOut();
                  Navigator.of(context!
                  ).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
  }
}

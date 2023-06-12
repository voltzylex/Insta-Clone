import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // sign up User
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String bio,
      required String userName,
      required Uint8List file}) async {
    String res = "Some Error Occured";
    try {} catch (e) {
      res = e.toString();
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          userName.isNotEmpty ||
          file != null) {
        // Regsiter User
        UserCredential crud = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    }
    return res;
  }
}

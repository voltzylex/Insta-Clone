import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> uploadImagetoStorage(
      {required String childName,
      required Uint8List file,
      required bool isPost}) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      ref.child(const Uuid().v1());
    }
    UploadTask upload = ref.putData(file);
    TaskSnapshot snap = await upload;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}

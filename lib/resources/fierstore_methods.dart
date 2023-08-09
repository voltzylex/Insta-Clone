import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  Future<String> uploadPost({
    required String uid,
    required Uint8List image,
    required String description,
    required String username,
    required String profileImage,
  }) async {
    // ignore: unused_local_variable
    String res = "some error occured";
    try {
      String photoUrl = await StorageMethods()
          .uploadImagetoStorage(childName: 'posts', file: image, isPost: true);
      String postId = const Uuid().v1();
      Posts post = Posts(
          description: description,
          uid: uid,
          userName: username,
          postId: postId,
          datePublished: DateTime.now(),
          likes: [],
          photUrl: photoUrl,
          profileImage: profileImage);
      _storage.collection("posts").doc(postId).set(post.toJson());
      return res = 'success';
    } catch (e) {
      log(e.toString());
      return res = e.toString();
    }
  }

  Future<void> likePost(String postId, String uid, List like) async {
    try {
      if (like.contains(uid)) {
        await _storage.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _storage.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> postComment(
      {required String postId,
      required String text,
      required String uid,
      required String name,
      required String profilePic}) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _storage
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'userName': name,
          'commentId': commentId,
          'text': text,
          'datePublished': DateTime.now()
        });
      } else {
        log("Post Comment : Text is Empty");
      }
    } catch (e) {
      log("Post comment $e");
    }
  }

  // Delete Function
  Future<void> deletePost(String postId) async {
    try {
      await _storage.collection("posts").doc(postId).delete();
    } catch (e) {
      log("error message : $e");
    }
  }
}

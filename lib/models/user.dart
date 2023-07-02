import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final String photoUrl;
  final List folowers;
  final List followings;
  User({
    required this.username,
    required this.uid,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.folowers,
    required this.followings,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "photoUrl": photoUrl,
        "folowers": folowers,
        "followings": followings,
      };
      static userFromSnap(DocumentSnapshot snapshot){
        var snap = snapshot.data() as Map<String, dynamic>;
        return User(
          username: snap["username"],
          uid: snap["uid"],
          email: snap["email"],
          bio: snap["bio"],
          photoUrl: snap["photoUrl"],
                    folowers: snap["folowers"],
                    followings: snap["followings"],
                  );
      }
}

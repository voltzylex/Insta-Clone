import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String description;
  final String uid;
  final String userName;
  final String postId;
  final  datePublished;
  final String photUrl;
  final String profileImage;
  final likes;
  Posts(
      {required this.description,
      required this.uid,
      required this.userName,
      required this.postId,
      required this.datePublished,
      required this.likes,
      required this.photUrl,
      required this.profileImage});
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "user_name": userName,
        "post_id": postId,
        "date_published": datePublished,
        "likes": likes,
        "phot_url": photUrl,
        "profile_image": profileImage
      };
  static postsFromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Posts(
      description: snap["description"],
      uid: snap["uid"],
      userName: snap["user_name"],
      postId: snap["post_id"],
      datePublished: snap["date_published"],
      likes: snap["likes"],
      photUrl: snap["phot_url"],
      profileImage: snap["profile_image"],
    );
  }
}

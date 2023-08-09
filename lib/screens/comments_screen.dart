import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/userProvider.dart';
import 'package:instagram_clone/resources/fierstore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key, required this.snap});
  final snap;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context, listen: true).getUser!;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comments"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: StreamBuilder(
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // log(snapshot.data!.docs[index].data().toString());
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) =>
                CommentCard(snap: snapshot.data!.docs[index].data()),
          );
        },
        stream: FirebaseFirestore.instance
            .collection("posts")
            .doc(widget.snap['post_id'])
            .collection("comments")
            .orderBy("datePublished", descending: true)
            .snapshots(),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.only(left: 16, right: 8),
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.all(8.0).copyWith(left: 8, right: 8),
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                        hintText: "Comment as ${user.username}",
                        border: InputBorder.none),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FireStoreMethods().postComment(
                      postId: widget.snap['post_id'],
                      text: commentController.text,
                      uid: user.uid,
                      name: user.username,
                      profilePic: user.photoUrl);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: const Text(
                    "Post",
                    style: TextStyle(color: blueColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

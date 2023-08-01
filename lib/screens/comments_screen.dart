import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';
import 'package:instagram_clone/widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: const CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.only(left: 16, right: 8),
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(avatarImage),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.all(8.0).copyWith(left: 8, right: 8),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: "Comment as user name",
                        border: InputBorder.none),
                  ),
                ),
              ),
              InkWell(
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

import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/fierstore_methods.dart';
import 'package:instagram_clone/screens/comments_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/userProvider.dart';

class PostCard extends StatefulWidget {
  PostCard(
      {super.key,
      required this.description,
      required this.profileImage,
      required this.userName,
      required this.postPhoto,
      required this.dataTime,
      required this.likes,
      required this.snap});
  final snap;
  String description;
  String profileImage;
  String userName;
  String postPhoto;
  DateTime dataTime;
  String likes;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool likeIsAnimating = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).getUser!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: const BoxDecoration(color: mobileBackgroundColor),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0)
                .copyWith(right: 0),
            child: Row(
              children: [
                // HEADER Section
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(widget.profileImage),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: ["Delete", "Edit"]
                                    .map((e) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ));
                  },
                  icon: const Icon(
                    Icons.more_vert_outlined,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          // IMAGE SECTION
          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethos().likePost(
                  widget.snap["post_id"], user.uid, widget.snap['likes']);
              setState(() {
                likeIsAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.postPhoto,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.network(avatarImage),
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: likeIsAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimationg: likeIsAnimating,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        likeIsAnimating = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                )
              ],
            ),
          ),
          // LIKE COMMENT SECTION
          Row(
            children: [
              LikeAnimation(
                isAnimationg: widget.likes.contains(user.uid ?? ""),
                child: IconButton(
                  onPressed: () async {
                    await FireStoreMethos().likePost(
                        widget.snap["post_id"], user.uid, widget.snap['likes']);
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  CommentsScreen(snap: widget.snap),
                    )),
                icon: const Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
              ),
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              const Expanded(child: SizedBox()),
              const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  ))
            ],
          ),
          //  DESCRIPTION AND NO OF COMMENT
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  child: Text(
                    "${widget.likes} likes",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      text: TextSpan(
                          text: "${widget.userName} ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: widget.description,
                            children: const [],
                            style:
                                const TextStyle(fontWeight: FontWeight.w400)),
                      ])),
                ),
                InkWell(
                  child: Container(
                    child: const Text(
                      "View all 200 comments",
                      style: TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                      DateFormat.yMMMd().format(widget.dataTime).toString(),
                      style:
                          const TextStyle(fontSize: 16, color: secondaryColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

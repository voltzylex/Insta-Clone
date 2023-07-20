import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  PostCard(
      {super.key,
      required this.description,
      required this.profileImage,
      required this.userName,
      required this.postPhoto,
      required this.dataTime,
      required this.likes});
  String description;
  String profileImage;
  String userName;
  String postPhoto;
  DateTime dataTime;
  String likes;

  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: NetworkImage(profileImage),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              postPhoto,
              errorBuilder: (context, error, stackTrace) =>
                  Image.network(avatarImage),
              fit: BoxFit.cover,
            ),
          ),
          // LIKE COMMENT SECTION
          const Row(
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              Expanded(child: SizedBox()),
              IconButton(
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
                    "$likes likes",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      text: TextSpan(
                          text: "$userName ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: description,
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
                  child: Text(DateFormat.yMMMd().format(dataTime).toString(),
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

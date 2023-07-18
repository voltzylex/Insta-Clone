import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

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
                const CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(avatarImage),
                ),
                const Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
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
              avatarImage,
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
                    "1,2 3 4 likes",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      text: const TextSpan(
                          text: "random",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: "This is some Description to be replaced",
                            children: [],
                            style: TextStyle(fontWeight: FontWeight.w400)),
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
                const Padding(
                  padding: EdgeInsets.all(0),
                  child: Text("10/12/2023",
                      style: TextStyle(fontSize: 16, color: secondaryColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

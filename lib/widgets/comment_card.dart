import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/global_variable.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key, this.snap});
  final snap;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(avatarImage),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "user name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: "Some desription to enter",
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                    ),
                    child: Text(
                      "23/12/32",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.favorite,
                  size: 16,
                )),
          ),
        ],
      ),
    );
  }
}

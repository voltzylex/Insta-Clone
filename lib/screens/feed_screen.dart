import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: SvgPicture.asset(
            instagramIcon,
            height: 30,
            color: primaryColor,
          ),
          actions: const [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.messenger_outline,
                  color: primaryColor,
                ))
          ],
        ),
        body: const PostCard());
  }
}

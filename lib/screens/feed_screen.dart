import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/providers/userProvider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';
import 'package:instagram_clone/widgets/post_card.dart';
import 'package:provider/provider.dart';

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: blueColor),
            );
          }
          // log(jsonDecode(snapshot.data!.docs.toString()).toString());
          return Provider.of<UserProvider>(context, listen: true).getUser ==
                  null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final snap = snapshot.data!.docs[index];
                    log(snapshot.data!.docs[index].data()['description']);
                    return PostCard(
                      snap: snap,
                      description: snap['description'],
                      postPhoto: snap['phot_url'],
                      profileImage: snap['profile_image'],
                      userName: snap['user_name'],
                      dataTime: snap['date_published'].toDate(),
                      likes: snap['likes'].length.toString(),
                    );
                  });
        },
      ),
    );
  }
}

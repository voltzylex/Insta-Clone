import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String? uid;
  const ProfileScreen({super.key, this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map userData = {};
  int postLength = 0, followers = 0, following = 0;
  bool isFollowing = false;
  final currentUid = FirebaseAuth.instance.currentUser!.uid;

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var posts = await FirebaseFirestore.instance
          .collection("posts")
          .where('uid', isEqualTo: widget.uid)
          .get();
      log("Posts data : ${posts.docs[0]["user_name"].toString()}");
      log("Response : ${response.data().toString()}");
      setState(() {
        isLoading = false;

        userData = response.data()!;
        postLength = posts.docs.length;
        followers = userData['folowers'].length;
        following = userData['followings'].length;
        isFollowing = userData["followings"].contains(currentUid);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log("get Data : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData['username'] ?? ""),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(userData['photoUrl']),
                            backgroundColor: blueColor,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(
                                        num: postLength, label: "Posts"),
                                    buildStatColumn(
                                        num: followers, label: "Followers"),
                                    buildStatColumn(
                                        num: following, label: "Followings"),
                                  ],
                                ),
                                currentUid == widget.uid
                                    ? FollowButton(
                                        text: "Edit Profile",
                                        buttonColor: mobileBackgroundColor,
                                        textColor: primaryColor,
                                        borderColor: Colors.grey,
                                        onFunction: () {},
                                      )
                                    : isFollowing
                                        ? FollowButton(
                                            text: "Unfollow",
                                            buttonColor: primaryColor,
                                            textColor: mobileBackgroundColor,
                                            borderColor: Colors.grey,
                                            onFunction: () {},
                                          )
                                        : FollowButton(
                                            text: "Follow",
                                            buttonColor: blueColor,
                                            textColor: primaryColor,
                                            borderColor: Colors.grey,
                                            onFunction: () {},
                                          ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData['username'].toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          userData['bio'].toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(),
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("posts")
                            .where('uid', isEqualTo: widget.uid)
                            .get(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                          }
                          return GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 1.5,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Hero(
                                        
                                        tag: "openImage",
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () => Navigator.pop(context),
                                            child: Image(
                                              image: NetworkImage(
                                                snapshot.data!.docs[index]
                                                    ['phot_url'],
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  child: Image(
                                    image: NetworkImage(
                                      snapshot.data!.docs[index]['phot_url'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  // decoration:
                                  // BoxDecoration(
                                  //   image: DecorationImage(
                                  //     fit: BoxFit.cover,
                                  //     image: NetworkImage(
                                  //       snapshot.data!.docs[index]['phot_url'],
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Column buildStatColumn({int? num, String? label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label.toString(),
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

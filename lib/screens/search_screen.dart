import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  bool isShowUser = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(labelText: 'search for user'),
          onFieldSubmitted: (String _) {
            log(_);
            setState(() {
              isShowUser = true;
            });
          },
        ),
      ),
      body: isShowUser
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where("username",
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                log(snapshot.data.toString());
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    log(index.toString());
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage((snapshot.data as dynamic)
                            .docs[index]['photoUrl']
                            .toString()),
                      ),
                      title: Text((snapshot.data as dynamic)
                          .docs[index]['username']
                          .toString()),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                log(snapshot.data.toString());
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StaggeredGridView.countBuilder(
                  itemCount: (snapshot.data as dynamic).docs.length,
                  crossAxisCount: 3,
                  itemBuilder: (context, index) =>
                      (snapshot.data as dynamic).docs != null
                          ? Image.network((snapshot.data as dynamic).docs[index]
                              ['phot_url'])
                          : const SizedBox(),
                  staggeredTileBuilder: (index) => StaggeredTile.count(
                      (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                );
              },
            ),
    );
  }
}

import 'dart:developer';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/providers/userProvider.dart';
import 'package:instagram_clone/resources/fierstore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool _isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;
  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Create a new post"),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            onPressed: () async {
              Navigator.pop(context);
              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                _file = file;
              });
            },
            child: const Text("Take a photo"),
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            onPressed: () async {
              Navigator.pop(context);
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                _file = file;
              });
            },
            child: const Text("Pick photo from gallery"),
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Future postImage(
      {required String uid,
      required String username,
      required String profileImage}) async {
    try {
      String res = await FireStoreMethods().uploadPost(
          uid: uid,
          image: _file!,
          description: _descriptionController.text,
          username: username,
          profileImage: profileImage);
      if (res == 'success') {
        clearImage();
        showSnackBar("Posted!", context);
      } else {
        showSnackBar(res, context);
      }
    } catch (e) {
      log(e.toString());
      showSnackBar(e.toString(), context);
    }
  }

  clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context, listen: false).getUser();
    // final User user =
    //     Provider.of<UserProvider>(context, listen: false).getUser!;
    return _file == null
        ? Center(
            child: IconButton(
              onPressed: () => _selectImage(context),
              icon: const Icon(Icons.upload),
            ),
          )
        : Consumer<UserProvider>(
            builder: (context, value, child) => value.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
                    appBar: AppBar(
                      backgroundColor: mobileBackgroundColor,
                      
                      leading: const IconButton(
                          onPressed: null, icon: Icon(Icons.arrow_back)),
                      title: const Text("Post to"),
                      centerTitle: false,
                      actions: [
                        TextButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              log(_isLoading.toString());
                              await postImage(
                                  uid: value.getUser!.uid,
                                  username: value.getUser!.username,
                                  profileImage: value.getUser!.photoUrl);
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            child: const Text(
                              "Post",
                              style: TextStyle(color: blueColor),
                            ))
                      ],
                    ),
                    body: Column(
                      children: [
                        _isLoading
                            ? const LinearProgressIndicator(
                                color: Colors.blue,
                              )
                            : const SizedBox(),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  value.getUser!.photoUrl),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                    hintText: "write a caption...",
                                    border: InputBorder.none),
                                maxLines: 8,
                              ),
                            ),
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: AspectRatio(
                                aspectRatio: 481 / 450,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: MemoryImage(_file!),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    )),
          );
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? image;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void selectedImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/ic_instagram.svg",
                  height: 40,
                  color: Colors.white,
                  alignment: Alignment.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    image != null
                        ? CircleAvatar(
                            radius: 50, backgroundImage: MemoryImage(image!))
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1685124762520-e7ddb57c9ce7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80"),
                          ),
                    Positioned(
                        bottom: -10,
                        // top: 50,
                        // left: 0,
                        right: 0,
                        child: IconButton(
                            onPressed: () {
                              selectedImage();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 20,
                            )))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    textEditingController: _usernameController,
                    hintText: "Enter Your UserName",
                    textInputType: TextInputType.name),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    textEditingController: _emailController,
                    hintText: "Enter Your Email",
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: "Enter Your Password",
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    textEditingController: _bioController,
                    hintText: "Enter Your Bio",
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    final data = await AuthMethods().signUpUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                        bio: _bioController.text,
                        userName: _usernameController.text,
                        file: image!);
                    final snackBar = SnackBar(
                      content: Text(data),
                      backgroundColor: (Colors.white),
                      action: SnackBarAction(
                        label: 'dismiss',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor,
                    ),
                    child: const Text("Sign up"),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(child: const Text("Dont have an Account? ")),
                      InkWell(
                          onTap: null,
                          child: Container(child: const Text("Create one"))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random/utils/colors.dart';
import 'package:random/widgets/text_field_input.dart';

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
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                height: 54,
                color: Colors.white,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 60,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1685124762520-e7ddb57c9ce7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80"),
                  ),
                  Positioned(
                      bottom: -10,
                      // top: 50,
                      left: 90,
                      // right: 0,
                      child: IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          )))
                ],
              ),
              SizedBox(
                height: 64,
              ),
              TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: "Enter Your UserName",
                  textInputType: TextInputType.name),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Enter Your Email",
                  textInputType: TextInputType.emailAddress),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter Your Password",
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  textEditingController: _bioController,
                  hintText: "Enter Your Bio",
                  textInputType: TextInputType.emailAddress),
              SizedBox(
                height: 64,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: blueColor,
                ),
                child: Text("Sign up"),
              ),
              SizedBox(
                height: 60,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(child: Text("Dont have an Account? ")),
                  InkWell(
                      onTap: null, child: Container(child: Text("Create one"))),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

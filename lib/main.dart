import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDK7KajoIRYuc3rNiVlwBn_MdiktO5qgzM",
          appId: "1:456319783001:web:656b4ca993951d3e8ee148",
          messagingSenderId: "456319783001",
          projectId: "insta-f5965",
          storageBucket: "insta-f5965.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Instagram Clone",
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: const Scaffold(
          body: ResponsiveLayout(
              mobileLayout: MobileScreen(), webLayout: WebScreen())),
    );
  }
}

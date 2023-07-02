import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/userProvider.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  String userName = "";
  int _page = 0;
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    // getUserDetails();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void pageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                })
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: pageChange,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Text("page 1"),
            Text("page 2"),
            Text("page 3"),
            Text("page 4"),
            Text("page 5"),
          ],
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          // activeColor: primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _page == 0 ? primaryColor : secondaryColor),
              backgroundColor: primaryColor,
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: _page == 1 ? primaryColor : secondaryColor),
              backgroundColor: primaryColor,
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_rounded,
                  color: _page == 2 ? primaryColor : secondaryColor),
              backgroundColor: primaryColor,
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: _page == 3 ? primaryColor : secondaryColor),
              backgroundColor: primaryColor,
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _page == 4 ? primaryColor : secondaryColor),
              backgroundColor: primaryColor,
              label: '',
            ),
          ],
          onTap: navigationTapped,
        ),
      ),
    );
  }
}

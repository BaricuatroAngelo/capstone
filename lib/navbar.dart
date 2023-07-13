import 'package:capstone/pages/ProfilePage.dart';
import 'package:capstone/pages/messaging.dart';
import 'package:capstone/pages/r_homepage.dart';
import 'package:capstone/pages/searchpatient.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;

  static final List<Widget> screens = [
    HomePage(),
    MessagePage(),
    SearchPatientPage(),
    ProfilePage(),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens.elementAt(currentIndex),
        bottomNavigationBar: GNav(
          onTabChange: _navigateBottomBar,
          backgroundColor: Color(0xff99E9FF),
          tabs: [
            GButton(
              icon: Icons.home_sharp,
              text: ' Home',
              textColor: Colors.white,
              iconColor: Colors.white54,
              iconActiveColor: Colors.white54,
            ),
            GButton(
              icon: Icons.message_sharp,
              text: 'Message',
              textColor: Colors.white,
              iconColor: Colors.white54,
              iconActiveColor: Colors.white54,
            ),
            GButton(
              icon: Icons.search_sharp,
              text: 'Search',
              textColor: Colors.white,
              iconColor: Colors.white54,
              iconActiveColor: Colors.white54,
            ),
            GButton(
              icon: Icons.manage_accounts_sharp,
              text: 'Profile',
              textColor: Colors.white,
              iconColor: Colors.white54,
              iconActiveColor: Colors.white54,
            ),
          ],
        ));
  }
}

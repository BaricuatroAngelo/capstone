import 'package:capstone/pages/ProfilePage.dart';
import 'package:capstone/pages/messaging.dart';
import 'package:capstone/pages/r_homepage.dart';
import 'package:capstone/pages/searchpatient.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:capstone/pages/Models/resident.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

class NavBar extends StatefulWidget {
  final String residentId;
  const NavBar({Key? key, required this.residentId}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      HomePage(residentId: widget.residentId),
      MessagePage(residentId: widget.residentId),
      SearchPatientPage(residentId: widget.residentId),
      ProfilePage(residentId: widget.residentId),
    ];
  }

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
        backgroundColor: const Color(0xff66d0ed),
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
      ),
    );
  }
}


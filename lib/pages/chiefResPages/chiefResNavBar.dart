import 'package:capstone/pages/debugPage.dart';
import 'package:capstone/pages/ProfilePage.dart';
import 'package:capstone/pages/chiefResPages/chiefHomePage.dart';
import 'package:capstone/pages/chiefResPages/chiefMessage.dart';
import 'package:capstone/pages/chiefResPages/chiefResProfile.dart';
import 'package:capstone/pages/chiefResPages/searchDoctors.dart';
import 'package:capstone/pages/messaging.dart';
import 'package:capstone/pages/r_homepage.dart';
import 'package:capstone/pages/searchpatient.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:animations/animations.dart';
import 'package:capstone/pages/Models/resident.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

class chiefNavBar extends StatefulWidget {
  final String residentId;
  final String authToken;
  const chiefNavBar({Key? key, required this.residentId, required this.authToken}) : super(key: key);

  @override
  State<chiefNavBar> createState() => _chiefNavBarState();
}

class _chiefNavBarState extends State<chiefNavBar> {
  int currentIndex = 0;
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      ChiefHomePage(residentId: widget.residentId, authToken: widget.authToken),
      ChiefMessagePage(residentId: widget.residentId, authToken: widget.authToken),
      SearchResidentPage(residentId: widget.residentId, authToken: widget.authToken,),
      ChiefProfilePage(residentId: widget.residentId, authToken: widget.authToken),
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
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 600), // Set the duration of the transition
        transitionBuilder: (
            Widget child,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
            ) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            child: child, // Choose the desired transition type
          );
        },
        child: screens.elementAt(currentIndex),
      ),
      bottomNavigationBar: GNav(
        onTabChange: _navigateBottomBar,
        backgroundColor: const Color(0xff66d0ed),
        tabs: [
          GButton(
            textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            icon: Icons.home_sharp,
            text: ' Home',
            iconColor: Colors.white54,
            iconActiveColor: Colors.white,
            iconSize: 40,
          ),
          GButton(
            textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            icon: Icons.message_sharp,
            text: ' Message',
            iconColor: Colors.white54,
            iconActiveColor: Colors.white,
            iconSize: 40,
          ),
          GButton(
            textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            icon: Icons.search_sharp,
            text: 'Search',
            iconColor: Colors.white54,
            iconActiveColor: Colors.white,
            iconSize: 40,
          ),
          GButton(
            textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            icon: Icons.manage_accounts_sharp,
            text: ' Profile',
            iconColor: Colors.white54,
            iconActiveColor: Colors.white,
            iconSize: 40,
          ),
        ],
      ),
    );
  }
}


import 'dart:ui';

import 'package:capstone/design/containers/widgets/urlWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:capstone/design/containers/widgets/profileInfoWidget.dart';
import 'Models/resident.dart';
import 'loginpage.dart';

class ProfilePage extends StatefulWidget {
  final String? authToken;
  final String residentId;

  const ProfilePage(
      {Key? key, required this.residentId, required this.authToken})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  double _calculateContainerHeight(BuildContext context) {
    // Get the screen height
    final screenHeight = MediaQuery.of(context).size.height;

    // Define your desired height range based on the screen height
    // You can adjust the values as per your preference
    if (screenHeight < 600) {
      // Small phones
      return 150;
    } else if (screenHeight < 1000) {
      // Medium-sized phones and small tablets
      return 200;
    } else {
      // Larger tablets and devices
      return 300;
    }
  }

  double _calculateContainerWidth(BuildContext context) {
    // Get the screen height
    final screenWidth = MediaQuery.of(context).size.height;

    // Define your desired height range based on the screen height
    // You can adjust the values as per your preference
    if (screenWidth < 600) {
      // Small phones
      return 150;
    } else if (screenWidth < 1000) {
      // Medium-sized phones and small tablets
      return 200;
    } else {
      // Larger tablets and devices
      return 300;
    }
  }


  double _calculateFontSize(BuildContext context) {
    // Get the screen height
    final screenHeight = MediaQuery.of(context).size.height;

    // Define your desired font size range based on the screen height
    // You can adjust the values as per your preference
    if (screenHeight < 600) {
      // Small phones
      return 16;
    } else if (screenHeight < 1000) {
      // Medium-sized phones and small tablets
      return 18;
    } else {
      // Larger tablets and devices
      return 22;
    }
  }
  Resident? _resident;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchResidentData();
  }

  Future<void> _fetchResidentData() async {
    final url =
        Uri.parse('${Env.prefix}/api/residents/${widget.residentId}');

    try {
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer ${widget.authToken}'});
      final responseData = json.decode(response.body);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _resident = Resident.fromJson(responseData);
          _isLoading = false;
        });
      } else {
        _showSnackBar('Failed to fetch resident data');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again later.');
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: const LoginPage(),
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final centerPosition = screenHeight / 2;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xff66d0ed).withOpacity(0.6),
                    const Color(0xff82eefd),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 25),
                child: Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Center(
                    child: SizedBox(
                      height: _calculateContainerHeight(context),
                      width: _calculateContainerWidth(context),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('asset/doctor.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: centerPosition - 90,
              left: 30,
              child: const Text(
                'Resident Information',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Color(0xff66d0ed)),
              ),
            ),
            if (!_isLoading) ...[
              Positioned(
                left: 15, right: 10, top: centerPosition - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfileInfoTile(
                        'Resident ID', _resident?.residentId ?? ''),
                    buildProfileInfoTile('Name',
                        '${_resident?.residentFName ?? ''} ${_resident?.residentMName ?? ''} ${_resident?.residentLName ?? ''}'),
                    buildProfileInfoTile(
                        'Username', _resident?.residentUserName ?? ''),
                    buildProfileInfoTile(
                        'Department ID', _resident?.departmentId ?? ''),
                    buildProfileInfoTile('Role', _resident!.role),
                  ],
                ),
              ),
            ],
            const Padding(padding: EdgeInsets.only( top: 60,),
                child: Center(
                  child: Text(
                    'Profile Page',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 1090, left: 30, right: 20),
              child: TextButton(
                  onPressed: _logout,
                  child: Center(
                    child: Text(
                      'Log out current account',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: _calculateFontSize(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

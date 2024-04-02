
import 'package:capstone/pages/chiefResPages/chiefResLogin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:capstone/design/containers/widgets/profileInfoWidget.dart';
import '../../design/containers/widgets/urlWidget.dart';
import '../Models/resident.dart';

class ChiefProfilePage extends StatefulWidget {
  final String? authToken;
  final String residentId;

  const ChiefProfilePage(
      {Key? key, required this.residentId, required this.authToken})
      : super(key: key);

  @override
  State<ChiefProfilePage> createState() => ChiefProfilePageState();
}

class ChiefProfilePageState extends State<ChiefProfilePage> {
  double _calculateContainerHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) {
      return 150;
    } else if (screenHeight < 1000) {
      return 200;
    } else {
      return 300;
    }
  }

  double _calculateContainerWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.height;
    if (screenWidth < 600) {
      return 150;
    } else if (screenWidth < 1000) {
      return 200;
    } else {
      return 300;
    }
  }

  double _calculateFontSize(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) {
      return 16;
    } else if (screenHeight < 1000) {
      return 18;
    } else {
      return 22;
    }
  }

  Resident _resident = Resident(
    residentId: '',
    residentUserName: '',
    residentFName: '',
    residentLName: '',
    residentPassword: '',
    role: '',
    departmentId: '',
    residentGender: '', isDeleted: 0, departmentName: '',
  );
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchResidentData();
  }

  Future<void> _fetchResidentData() async {
    final url = Uri.parse('${Env.prefix}/api/residents');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> residentsData = json.decode(response.body);

        final List<dynamic> filteredResidents = residentsData
            .where((resident) => resident['resident_id'] == widget.residentId)
            .toList();

        if (filteredResidents.isNotEmpty) {
          final residentData = filteredResidents.first;
          final resident = Resident.fromJson(residentData);
          setState(() {
            _isLoading = false;
            _resident = resident;
          });
        } else {
          print(response.body);
          _showSnackBar('Resident not found');
        }
      } else {
        _showSnackBar('Failed to fetch residents data');
      }
    } catch (e) {
      print(e);
      _showSnackBar('An error occurred. Please try again later.');
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
            child: const ChiefResLogin(),
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
                left: 15,
                right: 10,
                top: centerPosition - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfileInfoTile(
                        'Resident ID', _resident.residentId),
                    buildProfileInfoTile(
                        'Resident Name', '${_resident.residentFName} ${_resident.residentLName}'),
                    buildProfileInfoTile(
                        'Username', _resident.residentUserName),
                    buildProfileInfoTile(
                        'Dept Name', _resident.departmentName),
                    buildProfileInfoTile('Role', _resident.role),
                  ],
                ),
              ),
            ],
            const Padding(
                padding: EdgeInsets.only(
                  top: 60,
                ),
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
              padding: const EdgeInsets.only(
                  top: 835, bottom: 0, left: 30, right: 20),
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

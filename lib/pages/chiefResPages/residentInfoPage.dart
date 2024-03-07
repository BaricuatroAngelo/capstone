import 'dart:convert';

import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/pages/Models/Floor/Room/AssignedRoom.dart';
import 'package:capstone/pages/Models/resident.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../design/containers/widgets/profileInfoWidget.dart';
import '../../design/containers/widgets/urlWidget.dart';

class ResidentInfoPage extends StatefulWidget {
  final String authToken;
  final String residentId;
  final Resident resident;
  final AssignedRoom assignedRoom; // Add this line

  const ResidentInfoPage({
    Key? key,
    required this.authToken,
    required this.residentId,
    required this.resident,
    required this.assignedRoom, // Add this line
  }) : super(key: key);

  @override
  ResidentInfoPageState createState() => ResidentInfoPageState();
}

class ResidentInfoPageState extends State<ResidentInfoPage> {
  List<AssignedRoom> _allAssignedRooms = [];

  void initState() {
    super.initState();
    _fetchAllAssignedRooms();
  }

  Future<void> _fetchAllAssignedRooms() async {
    final url = Uri.parse('${Env.prefix}/api/resAssRooms');

    try {
      final response = await http.get (
          url,
          headers: {
            'Authorization' : 'Bearer ${widget.authToken}'
          }
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<AssignedRoom> assignedRooms = responseData.map((data) => AssignedRoom.fromJson(data)).toList();
        setState(() {
          _allAssignedRooms = assignedRooms;
        });
      } else {
        _showSnackBar('Failed to fetch resident assigned rooms.');
      }
    } catch (e){
      print(e);
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final centerPosition = screenHeight / 2;
    // final middleNameInitial = widget.resident.residentMName != 'null' &&
    //         widget.resident.residentMName.isNotEmpty
    //     ? '${widget.resident.residentMName[0]}. '
    //     : '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 0.0,
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 290) / 2),
          child: const Text('Resident Profile'),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: personName,
          ),
          Positioned(
            left: (screenWidth - 300) / 2,
            top: 50,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff99E9FF),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Image(
                image: AssetImage('asset/doctor.png'),
              ),
            ),
          ),
          Positioned(
            top: centerPosition - 120,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '${widget.resident.residentFName} ${widget.resident.residentLName}',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Positioned(
            top: centerPosition - 60,
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Divider(
                thickness: 3,
              ),
            ),
          ),
          Positioned(
            top: centerPosition - 40,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfileInfoTile(
                        'Resident ID', widget.resident.residentId ?? ''),
                    buildProfileInfoTile('Resident First Name',
                        widget.resident.residentFName ?? ''),
                    buildProfileInfoTile('Resident Last Name',
                        widget.resident.residentLName ?? ''),
                    // buildProfileInfoTile('Resident Middle Name',
                    //     widget.resident.residentMName ?? ''),
                    buildProfileInfoTile(
                        'Username', widget.resident.residentUserName ?? ''),
                    buildProfileInfoTile(
                        'Department ID', widget.resident.departmentId ?? ''),
                    buildProfileInfoTile('Assigned Room', widget.assignedRoom.roomId ?? ''),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:capstone/design/containers/containers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Models/resident.dart';
import 'Models/Floor/Room/AssignedRoom.dart';

class HomePage extends StatefulWidget {
  final String? residentId;
  final String? authToken;

  const HomePage({Key? key, required this.residentId, required this.authToken})
      : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Resident? _resident;
  List<AssignedRoom> _assignedRooms = [];

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
      return 24;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchResidentData();
    _fetchAssignedRooms();
  }

  Future<void> _fetchResidentData() async {
    final url =
        Uri.parse('http://10.0.2.2:8000/api/residents/${widget.residentId}');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );
      final responseData = json.decode(response.body);

      print(response.body);

      if (response.statusCode == 200) {
        final resident = Resident.fromJson(responseData);
        setState(() {
          _resident = resident;
        });
      } else {
        _showSnackBar('Failed to fetch resident data');
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again later.');
    }
  }

  Future<void> _fetchAssignedRooms() async {
    final url =
        Uri.parse('http://10.0.2.2:8000/api/ResAssRooms/${widget.residentId}');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
        },
      );

      print('Request URL: ${url.toString()}');
      print('Request Headers: ${response.request?.headers}');

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _assignedRooms =
              responseData.map((data) => AssignedRoom.fromJson(data)).toList();
        });
      } else {
        _showSnackBar('Failed to fetch assigned rooms');
      }
    } catch (e) {
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3F9FF),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xff66d0ed).withOpacity(0.4),
                  const Color(0xff82eefd),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100, left: 16),
                  child: Text(
                    'Hello,\n${_resident?.residentFName ?? ''}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black, // Use primary color
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 230),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: homeContainer,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Your Assigned Rooms:',
                      style: TextStyle(
                        fontSize: _calculateFontSize(context),
                        color: Colors.black, // Use primary color
                      ),
                    ),
                  ),
                  Expanded(
                    child: // Inside the ListView.builder:
                    ListView.builder(
                      itemCount: _assignedRooms.length,
                      itemBuilder: (context, index) {
                        final assignedRoom = _assignedRooms[index];
                        return Card(
                          elevation: 2, // Add elevation for the card-like appearance
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Text(
                              'Assigned Room ID: ${assignedRoom.assignedRoomId}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: _calculateFontSize(context),
                              ),
                            ),
                            subtitle: Text('Room ID: ${assignedRoom.roomId}'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../debugPage.dart';
import '../../design/containers/containers.dart';
import '../../design/containers/widgets/urlWidget.dart';
import '../Models/Floor/Room/Room.dart';
import '../Models/Patient/EHR.dart';
import '../PatientInfoPage.dart';

class ChiefHomePage extends StatefulWidget {
  final String authToken;
  final String residentId;

  const ChiefHomePage({
    Key? key,
    required this.residentId,
    required this.authToken,
  }) : super(key: key);

  @override
  ChiefHomePageState createState() => ChiefHomePageState();
}

class ChiefHomePageState extends State<ChiefHomePage> {
  late Map<String, List<Room>> _roomsByFloor = {};

  Future<void> _fetchRooms() async {
    final url = Uri.parse('${Env.prefix}/api/Rooms');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<Room> rooms =
            responseData.map((data) => Room.fromJson(data)).toList();

        setState(() {
          _roomsByFloor = _groupRoomsByFloor(rooms);
        });
      } else {
        _showSnackBar('Failed to fetch rooms');
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again later.');
      print(e);
    }
  }

  Map<String, List<Room>> _groupRoomsByFloor(List<Room> rooms) {
    Map<String, List<Room>> groupedRooms = {};

    for (var room in rooms) {
      if (!groupedRooms.containsKey(room.roomFloor)) {
        groupedRooms[room.roomFloor] = [];
      }
      groupedRooms[room.roomFloor]!.add(room);
    }

    return groupedRooms;
  }

  void _navigateToPatientDetailPage(String roomId) async {
    final patientHealthRecordResponse = await http.get(
      Uri.parse(
          '${Env.prefix}/api/PatientHealthRecord/getPatientbyRoom/$roomId'),
      headers: {'Authorization': 'Bearer ${widget.authToken}'},
    );

    if (patientHealthRecordResponse.statusCode == 200) {
      final List<dynamic> patientDataList =
          jsonDecode(patientHealthRecordResponse.body);

      if (patientDataList.isNotEmpty) {
        // Find the patient record with the matching room_id
        dynamic patientData = patientDataList.firstWhere(
            (data) => data['room_id'] == roomId,
            orElse: () => null);

        if (patientData != null) {
          PatientHealthRecord patientHealthRecord =
              PatientHealthRecord.fromJson(patientData);

          // Navigate to the PatientDetailPage with the patient's health record and room_id
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDetailPage(
                roomId: roomId,
                authToken: widget.authToken,
                patient: patientHealthRecord,
                patientId: patientHealthRecord.patientId,
              ),
            ),
          );
        } else {
          _showNoPatientDialog(context, roomId);
        }
      } else {
        _showNoPatientDialog(context, roomId);
      }
    } else {
      _showNoPatientDialog(context, roomId);
    }
  }

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
      return 200;
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
      return 24;
    }
  }

  void _showNoPatientDialog(BuildContext context, String roomId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Patient in Room $roomId'),
          content: const Text('There is currently no patient assigned to this room.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
  void initState() {
    super.initState();
    _fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final centerPosition = screenHeight / 2;
    return DefaultTabController(
      initialIndex: 0,
      length: _roomsByFloor.keys.length,
      child: Scaffold(
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
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 50, left: 16),
                  //   child: Text('Hello,\n${_resident?.residentFName ?? ''}',
                  //       style: GoogleFonts.poppins(
                  //         textStyle: const TextStyle(
                  //             fontSize: 40,
                  //             color: Colors.black54,
                  //             fontWeight: FontWeight.w700 // Use primary color
                  //             ),
                  //       )),
                  // ),
                  Center(
                      child: SizedBox(
                    height: _calculateContainerHeight(context),
                    width: _calculateContainerWidth(context),
                    child: const Image(
                      image: AssetImage('asset/ipimslogo.png'),
                    ),
                  ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: (screenHeight - (800)) / 2),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: homeContainer,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Floors:',
                        style: TextStyle(
                            fontSize: _calculateFontSize(context),
                            color: Colors.black,
                            fontWeight: FontWeight.bold // Use primary color
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TabBar(
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: _roomsByFloor.keys.map((roomFloor) {
                          return Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xffE3F9FF),
                            ),
                            child: Tab(
                              child: Text(
                                roomFloor,
                                style: TextStyle(
                                  color: Colors.black,
                                  // Set the color to make the text visible
                                  fontWeight: FontWeight.bold,
                                  fontSize: _calculateFontSize(context),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: TabBarView(
                          children: _roomsByFloor.keys.map((roomFloor) {
                            List<Room> rooms = _roomsByFloor[roomFloor]!;
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 30),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: rooms.length,
                                itemBuilder: (context, index) {
                                  Room room = rooms[index];
                                  return GestureDetector(
                                    onTap: (){
                                      _navigateToPatientDetailPage(room.roomId);
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shadowColor: const Color(0xff82eefd),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ListTile(
                                        title: Text('Room ID: ${room.roomId}'),
                                        subtitle: Text('Name: ${room.roomName}'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

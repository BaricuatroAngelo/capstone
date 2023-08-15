import 'package:capstone/design/containers/containers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Models/Floor/Room/Room.dart';
import 'Models/Patient/EHR.dart';
import 'Models/resident.dart';
import 'Models/Floor/Room/AssignedRoom.dart';
import 'PatientInfoPage.dart';

class HomePage extends StatefulWidget {
  final String? residentId;
  final String authToken;

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

  @override
  void initState() {
    super.initState();
    _fetchResidentData();
    _fetchAssignedRooms();
    _fetchRooms();
  }

  Map<String, List<Room>> _roomsByFloor = {};

  Future<void> _fetchRooms() async {
    final url = Uri.parse('http://172.30.0.28:8000/api/Rooms');
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

  Future<void> _fetchResidentData() async {
    final url =
        Uri.parse('http://172.30.0.28:8000/api/residents/${widget.residentId}');

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
        Uri.parse('http://172.30.0.28:8000/api/ResAssRooms/${widget.residentId}');

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

  void _navigateToPatientDetailPage(String roomId) async {
    final patientHealthRecordResponse = await http.get(
      Uri.parse(
          'http://172.30.0.28:8000/api/PatientHealthRecord/getPatientbyRoom/$roomId'),
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
  void dispose() {
    super.dispose();
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
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Your Assigned Rooms:',
                        style: TextStyle(
                          fontSize: _calculateFontSize(context),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _assignedRooms.map((assignedRoom) {
                          return Container(
                            width: 200,
                            height: 130, // Adjust the width as needed
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {
                                _navigateToPatientDetailPage(
                                    assignedRoom.roomId);
                              },
                              child: Card(
                                elevation: 7,
                                shadowColor: const Color(0xff82eefd),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Room ${assignedRoom.roomId}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                _calculateFontSize(context),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Center(
                                        child: Icon(
                                          Icons.hotel,
                                          size: 60,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
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
                    TabBar(
                      indicatorColor: Colors.black26,
                      dividerColor: Colors.blue,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: _roomsByFloor.keys.map((roomFloor) {
                        return Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff82eefd),
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
                                  return Card(
                                    shadowColor: const Color(0xff82eefd),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                        _navigateToPatientDetailPage(room.roomId);
                                      },
                                      child: ListTile(
                                        title: Text(
                                          'Room ID: ${room.roomId}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text('Room ${room.roomName}'),
                                        // Add more details as needed
                                      ),
                                    )
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

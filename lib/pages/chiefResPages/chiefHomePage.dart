import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:capstone/pages/Models/Patient/patient.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../design/containers/containers.dart';
import '../../design/containers/widgets/urlWidget.dart';
import '../Models/Floor/Room/AssignedRoom.dart';
import '../Models/Floor/Room/Room.dart';
import '../Models/Patient/EHR.dart';
import '../Models/resident.dart';
import '../PatientInfoPage.dart';
import '../wardPatients.dart';

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
  Resident? _resident;
  List<AssignedRoom> _assignedRooms = [];
  final List<AssignedRoom> _allAssignedRooms = [];

  double _calculateContainerHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (screenHeight < 600) {
      // Small phones
      return 150;
    } else if (screenHeight < 1000) {
      return 200;
    } else {
      return 200;
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
      return 24;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchResidentData();
    _fetchAssignedRooms();
    _fetchRooms();
    _fetchAllAssignedRooms();
  }



  Map<String, List<Room>> _roomsByFloor = {};

  Future<void> _fetchRooms() async {
    final url = Uri.parse('${Env.prefix}/api/rooms');
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
      if (_isRoomAssigned(room.roomId)) {
        // Exclude assigned rooms
        continue;
      }

      if (!groupedRooms.containsKey(room.roomFloor)) {
        groupedRooms[room.roomFloor] = [];
      }
      groupedRooms[room.roomFloor]!.add(room);
    }

    return groupedRooms;
  }

  bool _isRoomAssigned(String roomId) {
    return _assignedRooms.any((assignedRoom) => assignedRoom.roomId == roomId);
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

        // Filter residents based on residentId
        final List<dynamic> filteredResidents = residentsData
            .where((resident) => resident['resident_id'] == widget.residentId)
            .toList();

        if (filteredResidents.isNotEmpty) {
          final residentData = filteredResidents.first;
          final resident = Resident.fromJson(residentData);
          setState(() {
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
    }
  }

  Set<String> _assignedRoomIds = {};

  Map<String, List<AssignedRoom>> assignedRoomsByResidentId = {};
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
          assignedRoomsByResidentId = _groupRoomsByResidentId(assignedRooms);
        });
      } else {
        _showSnackBar('Failed to fetch resident assigned rooms.');
      }
    } catch (e){
      print(e);
    }
  }

  Map<String, List<AssignedRoom>> _groupRoomsByResidentId(List<AssignedRoom> assignedRooms) {
    Map<String, List<AssignedRoom>> groupedAssignedRooms = {};
    for (var assignedRoom in assignedRooms) {
      if(_isRoomAssigned(assignedRoom.roomId)) {
        continue;
      }

      if(!groupedAssignedRooms.containsKey(assignedRoom.residentId)) {
        groupedAssignedRooms[assignedRoom.residentId] = [];
      }
      groupedAssignedRooms[assignedRoom.residentId]!.add(assignedRoom);
    }
    return groupedAssignedRooms;
  }

  Future<void> _fetchAssignedRooms() async {
    final url = Uri.parse('${Env.prefix}/api/resAssRooms/${widget.residentId}');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _assignedRooms =
              responseData.map((data) => AssignedRoom.fromJson(data)).toList();
          _assignedRoomIds = Set.from(
              _assignedRooms.map((assignedRoom) => assignedRoom.roomId));
        });
      } else {
        _showSnackBar('Failed to fetch assigned rooms');
      }
    } catch (e) {
    }
  }

  void _navigateToPatientDetailPage(String roomId) async {
    print(roomId);
    try {
      final patientHealthRecordResponse = await http.get(
        Uri.parse('${Env.prefix}/api/patAssRooms/getPatientbyRoom/$roomId'),
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      if (patientHealthRecordResponse.statusCode == 200) {
        final dynamic responseData = jsonDecode(patientHealthRecordResponse.body);
        print(responseData);

        if (responseData is Map && responseData.containsKey('message')) {

          _showNoPatientDialog(context, roomId);
        } else {

          final List<dynamic> patientList = responseData;
          if (patientList.isNotEmpty) {
            final dynamic patientData = patientList[0];
            final Patient patientHealthRecord = Patient.fromJson(patientData);
            final String patientId = patientHealthRecord.patientId;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientDetailPage(
                  authToken: widget.authToken,
                  patient: patientHealthRecord,
                  patientId: patientId,
                  residentId: widget.residentId,
                ),
              ),
            );
          } else {
            _showNoPatientDialog(context, roomId);
          }
        }
      } else {
        _showNoPatientDialog(context, roomId);
      }
    } catch (e) {
      print(e);
      _showNoPatientDialog(context, roomId);
    }
  }



  void _navigateToWardPatientPage(String roomId) async {
    if (roomId.startsWith('RAE')) {
      final patientHealthRecordResponse = await http.get(
        Uri.parse(
            '${Env.prefix}/api/patAssRooms/getPatientbyRoom/$roomId'),
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      print(patientHealthRecordResponse.body);
      if (patientHealthRecordResponse.statusCode == 200) {
        final List<dynamic> patientDataList =
        jsonDecode(patientHealthRecordResponse.body);

        print(patientDataList);

        if (patientDataList.isNotEmpty) {
          dynamic patientData = patientDataList.firstWhere(
                  (data) => data['room_id'] == roomId,
              orElse: () => null);

          if (patientData != null) {
            PatientHealthRecord patientHealthRecord =
            PatientHealthRecord.fromJson(patientData);


            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomPatientsPage(
                  roomId: roomId,
                  authToken: widget.authToken,
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
  }

  void _showNoPatientDialog(BuildContext context, String roomId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Patient in Room $roomId'),
          content: const Text(
              'There is currently no patient assigned to this room.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
    // final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    // final centerPosition = screenHeight / 2;
    if (_resident == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child:
          CircularProgressIndicator(),
        ),
      );
    }

    // Continue building the UI once data is available
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
                Center(
                  child: SizedBox(
                    height: _calculateContainerHeight(context),
                    width: _calculateContainerWidth(context),
                    child: const Image(
                      image: AssetImage('asset/ipimslogo.png'),
                    ),
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: (screenHeight - (600)) / 2),
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
                            width: 150,
                            height: 120,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {
                                if (assignedRoom.roomId.startsWith('RAE')) {
                                  _navigateToPatientDetailPage(
                                      assignedRoom.roomId);
                                } else {
                                  _navigateToPatientDetailPage(
                                      assignedRoom.roomId);
                                }
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
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 30),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Residents Assigned Floors:',
                        style: TextStyle(
                            fontSize: _calculateFontSize(context),
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Accordion(
                      scaleWhenAnimating: true,
                      openAndCloseAnimation: true,
                      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                      sectionClosingHapticFeedback: SectionHapticFeedback.light,
                      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                      children: [
                        for (var residentId in assignedRoomsByResidentId.keys)
                          AccordionSection(
                            headerBackgroundColor: const Color(0xff82eefd),
                            headerBackgroundColorOpened: const Color(0xff66d0ed),
                            header: Padding(
                              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                              child: Text(
                                'Assigned Room of $residentId',
                                style: TextStyle(
                                  fontSize: _calculateFontSize(context),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            content: SizedBox(
                              height: 300, // Set the height you desire
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 3,
                                children: assignedRoomsByResidentId[residentId]!.map((assignedRoom) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (assignedRoom.roomId.startsWith('RAE')) {
                                        _navigateToPatientDetailPage(assignedRoom.roomId);
                                      } else {
                                        _navigateToPatientDetailPage(assignedRoom.roomId);
                                      }
                                    },
                                    child: Card(
                                      elevation: 7,
                                      shadowColor: const Color(0xff82eefd),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Center(
                                          child: Text(
                                            'Room ${assignedRoom.roomId}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: _calculateFontSize(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                      ],
                    ),
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

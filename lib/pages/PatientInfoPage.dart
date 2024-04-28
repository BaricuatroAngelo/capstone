import 'dart:convert';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:capstone/pages/Models/Patient/patient.dart';
import 'package:capstone/pages/PostResults.dart';
import 'package:capstone/pages/uploadPage.dart';
import 'package:capstone/pages/medicine_page.dart';
import 'package:capstone/pages/patient/patientHealthRecord.dart';
import 'package:capstone/pages/patientPhysicalExam.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../design/containers/containers.dart';
import '../design/containers/widgets/urlWidget.dart';
import 'Models/Floor/Room/Room.dart';

class PatientDetailPage extends StatefulWidget {
  final String patientId;
  final String authToken;
  final Patient patient;
  final String residentId;

  const PatientDetailPage({
    Key? key,
    required this.patient,
    required this.patientId,
    required this.authToken,
    required this.residentId,
  }) : super(key: key);

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  List<Room> _rooms = [];
  String? _selectedRoomId;

  Future<void> transferPatient(
      String patientId, String roomId, String authToken) async {
    final transferUrl = Uri.parse(
        '${Env.prefix}/api/patAssRooms/transferPatient/$patientId');

    try {
      final response = await http.post(
        transferUrl,
        headers: {'Authorization': 'Bearer $authToken'},
        body: {'room_id': roomId},
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        // Handle successful transfer
        ElegantNotification.success(
            position: Alignment.topCenter,
            animation: AnimationType.fromTop,
            description: const Text('Patient transferred successfully', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
            .show(context);
      } else if (response.statusCode == 404) {
        // Patient not found in patAssRooms
        ElegantNotification.error(
          position: Alignment.topCenter,
          animation: AnimationType.fromTop,
          description: const Text('Patient is not assigned to a room.',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ).show(context);
      } else {
        // Handle other cases if needed
        ElegantNotification.error(
            position: Alignment.topCenter,
            animation: AnimationType.fromTop,
            description: const Text('Failed to transfer patient',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
            .show(context);
      }
    } catch (e) {
      // Handle exceptions during transfer
      ElegantNotification.error(
          position: Alignment.topCenter,
          animation: AnimationType.fromTop,
          description: const Text('An error occurred during transfer',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
          .show(context);
      print('Exception during transfer: $e');
    }
  }


  void _onRoomSelected(String? roomId) {
    setState(() {
      _selectedRoomId = roomId;
    });
  }

// Function to trigger patient transfer
  void confirmTransfer(BuildContext context) {
    if (_selectedRoomId == null) {
      _showSnackBar('Please select a room');
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Transfer'),
          content: Text(
              'Are you sure you want to transfer this patient to $_selectedRoomId'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                transferPatient(
                    widget.patientId, _selectedRoomId!, widget.authToken);
                Navigator.of(context).pop(true); // Dismiss the dialog
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchRooms() async {
    final url = Uri.parse('${Env.prefix}/api/rooms');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<Room> rooms =
            responseData.map((data) => Room.fromJson(data)).toList();

        setState(() {
          _rooms = rooms;
        });
      } else {
        ElegantNotification.error(
            position: Alignment.topCenter,
            animation: AnimationType.fromTop,
            description: const Text('Failed to load room list. Please try again.'));
      }
    } catch (e) {
      ElegantNotification.error(
          position: Alignment.topCenter,
          animation: AnimationType.fromTop,
          description: const Text('An error occured. Please try again.'));
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

  void navigateToPhysicalExamPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PhysExam(
            authToken: widget.authToken,
            patient: widget.patient,
            patientId: widget.patientId),
      ),
    );
  }

  void navigateToHealthRecordPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PatientHealthRecordPage(
        patient: widget.patient,
        authToken: widget.authToken,
        patientId: widget.patientId,
      ),
    ));
  }

  void navigateToMedicinePage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MedicineSelectionPage(
        patient: widget.patient,
        authToken: widget.authToken,
        patientId: widget.patientId,
      ),
    ));
  }

  void navigateToResultsPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LabResultsPage(
        patient: widget.patient,
        authToken: widget.authToken,
        patientId: widget.patientId,
      ),
    ));
  }


  Future<void> checkoutPatient(String patientId, String authToken) async {
    final checkoutUrl = Uri.parse(
        '${Env.prefix}/api/patAssRooms/checkout/$patientId');

    try {
      final response = await http.get(
        checkoutUrl,
        headers: {'Authorization': 'Bearer $authToken'},
      );

      if (response.statusCode == 200) {
        // Handle successful checkout
        ElegantNotification.success(
            position: Alignment.topCenter,
            animation: AnimationType.fromTop,
            description: const Text('Patient has been discharged', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
            .show(context);
      } else {
        // Handle unsuccessful checkout
        ElegantNotification.error(
            position: Alignment.topCenter,
            animation: AnimationType.fromTop,
            description: const Text('Failed to discharge patient',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
            .show(context);
      }
    } catch (e) {
      // Handle exceptions during checkout
      ElegantNotification.error(
          position: Alignment.topCenter,
          animation: AnimationType.fromTop,
          description: const Text('An error occurred. Please try again.',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
          .show(context);
      print('Exception during checkout: $e');
    }
  }


  void confirmCheckout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Checkout',
            style: TextStyle(fontSize: 24),
          ),
          content: const Text(
            'Are you sure you want to discharge this patient?',
            style: TextStyle(fontSize: 24),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Dismiss the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 24),
              ),
            ),
            TextButton(
              onPressed: () {
                checkoutPatient(widget.patientId, widget.authToken);
                Navigator.of(context).pop(true); // Dismiss the dialog
              },
              child: const Text(
                'Confirm',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        );
      },
    );
  }

  void _openRoomSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select a Room',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(), // Set physics
                  itemCount: _rooms.length,
                  itemBuilder: (BuildContext context, int index) {
                    Room room = _rooms[index];
                    return ListTile(
                      title: Text(room.roomName),
                      onTap: () {
                        Navigator.pop(context, room.roomId);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).then((selectedRoomId) {
      if (selectedRoomId != null) {
        setState(() {
          _selectedRoomId = selectedRoomId;
        });
        confirmTransfer(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRooms();
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 3.0,
        shadowColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 350) / 2),
          child: const Text(
            'Patient Profile',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: _openRoomSelection,
              icon: const Icon(
                Icons.transfer_within_a_station,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                confirmCheckout(context); // Show confirmation dialog
              },
              icon: const Icon(
                Icons.check,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(
                Icons.upload,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FileUploadPage(
                          authToken: widget.authToken,
                          residentId: widget.residentId,
                          patientId: widget.patientId,
                        )));
              },
            ),
          )
        ],
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
            top: 100,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.09),
                    blurRadius: 10,
                    offset: const Offset(10, 20),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: centerPosition - 75,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '${widget.patient.patient_fName} ${widget.patient.patient_mName} ${widget.patient.patient_lName}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: centerPosition, left: 100, right: 0),
            child: GestureDetector(
              onTap: () {
                navigateToHealthRecordPage();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xff66d0ed),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 10,
                      offset: const Offset(10, 20),
                    ),
                  ],
                ),
                width: 400,
                height: 100,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Patient Health Record',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: centerPosition + 120, left: 100, right: 0),
            child: GestureDetector(
              onTap: () {
                navigateToMedicinePage();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xff66d0ed),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 10,
                      offset: const Offset(10, 20),
                    ),
                  ],
                ),
                width: 400,
                height: 100,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Medicine',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: centerPosition + 240, left: 100, right: 0),
            child: GestureDetector(
              onTap: () {
                navigateToResultsPage();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xff66d0ed),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 10,
                      offset: const Offset(10, 20),
                    ),
                  ],
                ),
                width: 400,
                height: 100,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.analytics,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Results',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToPhysicalExamPage();
        },
        tooltip: 'PhysExam',
        backgroundColor: const Color(0xff66d0ed),
        child: const Icon(Icons.accessibility),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

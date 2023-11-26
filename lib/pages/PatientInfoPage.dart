import 'dart:convert';

import 'package:capstone/pages/Models/Patient/EHR.dart';
import 'package:capstone/pages/Models/Patient/patient.dart';
import 'package:capstone/pages/PostResults.dart';
import 'package:capstone/pages/debugPage.dart';
import 'package:capstone/pages/medicine_page.dart';
import 'package:capstone/pages/patient/patientHealthRecord.dart';
import 'package:capstone/pages/patientPhysicalExam.dart';
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

  PatientDetailPage({
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
        _showSnackBar('Failed to fetch rooms');
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again later.');
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
    final url = Uri.parse('${Env.prefix}/api/patAssRooms/checkout/$patientId');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $authToken'},
      );
      if (response.statusCode == 200) {
        print(response.statusCode);
      } else {
        // Handle unsuccessful checkout
        showPatientNotAssignedDialog(context);
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during checkout: $e');
    }
  }

  void showPatientNotAssignedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Patient Not Assigned'),
          content: Text('This patient is not currently assigned to a room.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void confirmCheckout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Checkout'),
          content: Text('Are you sure you want to checkout this patient?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Dismiss the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                checkoutPatient(widget.patientId, widget.authToken);
                Navigator.of(context).pop(true); // Dismiss the dialog
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
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
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.transfer_within_a_station,
                size: 30,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              confirmCheckout(context); // Show confirmation dialog
            },
            icon: Icon(
              Icons.check,
              size: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
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
            left: (screenWidth - 400) / 2,
            top: 120,
            child: Container(
              height: 400,
              width: 400,
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
            padding: EdgeInsets.only(top: centerPosition, left: 250, right: 0),
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
                EdgeInsets.only(top: centerPosition + 150, left: 250, right: 0),
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
                EdgeInsets.only(top: centerPosition + 300, left: 250, right: 0),
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
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          navigateToPhysicalExamPage();
        },
        tooltip: 'PhysExam',
        child: Icon(Icons.tab),
        backgroundColor: const Color(0xff66d0ed),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

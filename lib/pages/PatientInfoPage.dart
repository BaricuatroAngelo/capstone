import 'package:capstone/pages/Models/Patient/EHR.dart';
import 'package:capstone/pages/patient/patientHealthRecord.dart';
import 'package:flutter/material.dart';

import '../design/containers/containers.dart';

class PatientDetailPage extends StatefulWidget {
  final String patientId;
  final String authToken;
  final PatientHealthRecord patient;
  final String? roomId;

  const PatientDetailPage({
    Key? key,
    required this.patient,
    required this.patientId,
    required this.authToken,
    required this.roomId,
  }) : super(key: key);

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  void navigateToHealthRecordPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PatientHealthRecordPage(
        // Pass any necessary data to the PatientHealthRecordPage
        patient: widget.patient,
        authToken: widget.authToken,
      ),
    ));
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
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 350) / 2),
          child: const Text('Patient Profile', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
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
                    offset: Offset(10, 20),
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
                '${widget.patient.firstName} ${widget.patient.middleName} ${widget.patient.lastName}',
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
              onTap: (){
                navigateToHealthRecordPage();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xff66d0ed),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 10,
                      offset: Offset(10, 20),
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
                      size: 30,
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
        ],
      ),
    );
  }
}

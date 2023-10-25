import 'package:flutter/material.dart';

import 'Models/Patient/patient.dart';

class PhysExam extends StatefulWidget {
  final String authToken;
  final Patient patient;

  const PhysExam({Key? key, required this.authToken, required this.patient})
      : super(key: key);

  @override
  State<PhysExam> createState() => PhysExamState();
}

class PhysExamState extends State<PhysExam> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 2,
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 630) / 2),
          child: Text(
            '${widget.patient.patient_id} Physical Exam Record',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(),
    );
  }
}

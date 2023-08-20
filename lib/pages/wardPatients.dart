import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/EHR.dart';

class RoomPatientsPage extends StatefulWidget {
  final String authToken;
  final String roomId;

  const RoomPatientsPage({
    Key? key,
    required this.authToken,
    required this.roomId,
  }) : super(key: key);

  @override
  _RoomPatientsPageState createState() => _RoomPatientsPageState();
}

class _RoomPatientsPageState extends State<RoomPatientsPage> {
  List<PatientHealthRecord> _patients = [];

  @override
  void initState() {
    super.initState();
    _fetchPatientsByRoom();
  }

  Future<void> _fetchPatientsByRoom() async {
    final patientHealthRecordResponse = await http.get(
      Uri.parse(
          '${Env.prefix}/api/PatientHealthRecord/getPatientbyRoom/${widget.roomId}'),
      headers: {'Authorization': 'Bearer ${widget.authToken}'},
    );

    if (patientHealthRecordResponse.statusCode == 200) {
      final List<dynamic> patientDataList =
      jsonDecode(patientHealthRecordResponse.body);
      setState(() {
        _patients = patientDataList
            .map((data) => PatientHealthRecord.fromJson(data))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients in Room ${widget.roomId}'),
      ),
      body: ListView.builder(
        itemCount: _patients.length,
        itemBuilder: (context, index) {
          final patient = _patients[index];
          return Card(
            elevation: 7,
            shadowColor: const Color(0xff82eefd),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text('Patient ID: ${patient.patientId}'),
              // Use the correct property here
              subtitle: Text('Name: ${patient.firstName}'),
              onTap: () {

              },
            ),
          );
        },
      ),
    );
  }
}

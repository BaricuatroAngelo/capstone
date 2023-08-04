import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/pages/ResultsPage.dart';
import 'package:capstone/pages/selectedMeds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../design/containers/text.dart';
import 'Models/Patient/patient.dart';

class PatientInfoPage extends StatefulWidget {
  final String authToken;
  final String patientId;

  const PatientInfoPage(
      {super.key, required this.patientId, required this.authToken});

  @override
  PatientInfoPageState createState() => PatientInfoPageState();
}

class PatientInfoPageState extends State<PatientInfoPage> {
  late final Patient patient;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPatientDetails();
  }

  Future<void> _fetchPatientDetails() async {
    final url =
        Uri.parse('http://10.0.2.2:8000/api/PatientHealthRecord/${widget.patientId}');
    try {
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer ${widget.authToken}'});
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          patient = Patient.fromJson(responseData);
          _isLoading = false;
        });
      } else {
        _showSnackBar('Failed to fetch patient details');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again later.');
      setState(() {
        _isLoading = false;
      });
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
    final middleNameInitial =
        patient.middleName != 'null' && patient.middleName.isNotEmpty
            ? '${patient.middleName[0]}. '
            : '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 0.0,
        toolbarHeight: 80,
        title: Padding  (
          padding: EdgeInsets.only(left: (screenWidth - 290) / 2),
          child: const Text('Patient Detail'),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : patient != null
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: personName,
                    ),
                    Positioned(
                      left: (screenWidth - 300) / 2,
                      top: 180,
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff99E9FF),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: centerPosition - 100,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          '${patient.firstName} $middleNameInitial${patient.lastName}',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Positioned(
                      top: centerPosition - 57,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: 300,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image(
                                      image: AssetImage('asset/syringee.png'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    patient!.vaccinationStatus,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                              Text(
                                'Age: ${patient.age.toString()}',
                                style: const TextStyle(fontSize: 24),
                              ),
                              Container(
                                height: 50,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color:
                                      const Color(0xffFF8A8A).withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Center(
                                    child: Text(
                                      'Sex: ${patient.sex}',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: (screenHeight - (-50)) / 2,
                      left: 30,
                      child: const Text(
                        'Doctor Notes',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: (screenWidth - (-700)) / 2,
                          top: (screenHeight - (-55)) / 2,
                          right: 30),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffE3F9FF),
                          ),
                          child: const Icon(Icons.edit),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: (screenHeight - (-170)) / 2),
                      child: Container(
                        width: screenWidth,
                        height: (screenHeight - 500) / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff99E9FF),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text('Patient not found.'),
                ),
    );
  }
}

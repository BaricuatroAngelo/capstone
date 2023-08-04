import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/pages/Models/resident.dart';
import 'package:capstone/pages/ResultsPage.dart';
import 'package:capstone/pages/selectedMeds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResidentInfoPage extends StatefulWidget {
  final String authToken;
  final String residentId;

  const ResidentInfoPage(
      {super.key, required this.residentId, required this.authToken});

  @override
  ResidentInfoPageState createState() => ResidentInfoPageState();
}

class ResidentInfoPageState extends State<ResidentInfoPage> {
  late final Resident resident;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchResidentDetails();
  }

  Future<void> _fetchResidentDetails() async {
    final url =
        Uri.parse('http://10.0.2.2:8000/api/residents/${widget.residentId}');
    try {
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer ${widget.authToken}'});
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          resident = Resident.fromJson(responseData);
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
        resident.residentMName != 'null' && resident.residentMName.isNotEmpty
            ? '${resident.residentMName[0]}. '
            : '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 0.0,
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 290) / 2),
          child: const Text('Resident Profile'),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : resident != null
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: personName,
                    ),
                    Positioned(
                      left: (screenWidth - 400) / 2,
                      top: 50,
                      child: Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
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
                      top: centerPosition - 120,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          '${resident.residentFName} $middleNameInitial${resident.residentLName}',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Positioned(
                      top: centerPosition - 67,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: 300,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Res. ID: ${resident.residentId}',
                                style: const TextStyle(fontSize: 24),
                              ),
                              Container(
                                height: 50,
                                width: 190,
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
                                      'Dept. ID: ${resident.departmentId}',
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
                  ],
                )
              : const Center(
                  child: Text('Patient not found.'),
                ),
    );
  }
}

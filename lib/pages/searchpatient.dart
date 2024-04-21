// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:async';

import 'package:capstone/design/containers/containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../design/containers/widgets/urlWidget.dart';
import '../providers/constants.dart';
import 'Models/Patient/patient.dart';
import 'Models/Patient/residentAssignedPatient.dart';
import 'PatientInfoPage.dart';

class SearchPatientPage extends StatefulWidget {
  final String residentId;
  final String authToken;

  const SearchPatientPage(
      {Key? key, required this.residentId, required this.authToken})
      : super(key: key);

  @override
  State<SearchPatientPage> createState() => _SearchPatientPageState();
}

class _SearchPatientPageState extends State<SearchPatientPage> {
  List<Patient> _patients = [];
  List<Patient> _filteredPatients = [];
  List<ResAssPat> _resAssPat = [];
  final SortType _sortType = SortType.Name;
  final bool _isNameAscending = true;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _isLoading = true;
  late Timer _timer;

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
      return 22;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPatients();
    _fetchResidentAssignedPatients();
    // Start the timer to fetch data every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _fetchPatients();
    });
  }


// Function to fetch Resident Assigned Patients
  Future<void> _fetchResidentAssignedPatients() async {
    final url = Uri.parse('${Env.prefix}/api/residentAssignedPatients/get/PatientsAssignedToResident');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        setState(() {
          _resAssPat = responseData.map((data) => ResAssPat.fromJson(data)).toList();
          _isLoading = false;
          print(responseData);
        });
      } else {
        setState(() {
          _showSnackBar ('Failed to fetch Resident Assigned Patients.');
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _showSnackBar('An error occurred while fetching Resident Assigned Patients.');
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchPatients() async {
    final url = Uri.parse('${Env.prefix}/api/patients');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        // Get all patient IDs assigned to the resident
        final assignedPatientIds = _resAssPat.map((resAssPat) => resAssPat.patientId).toList();

        // Filter the list of all patients to retain only those with matching patient IDs
        final filteredPatients = responseData
            .map((data) => Patient.fromJson(data))
            .where((patient) => assignedPatientIds.contains(patient.patientId))
            .toList();

        setState(() {
          _patients = filteredPatients;
          _filteredPatients = List.from(_patients);
          _isLoading = false;
        });
      } else {
        _showSnackBar('Failed to fetch patients');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again later.');
      setState(() {
        _isLoading = false;
      });
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

  void _filterPatients(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      _filteredPatients = _patients.where((patient) {
        final fullName =
            '${patient.patient_fName} ${patient.patient_lName}'.toLowerCase();
        return fullName.contains(query.toLowerCase()) ||
            patient.patientId.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _onPatientSelected(Patient patient) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          // Set the duration of the transition
          pageBuilder: (context, animation, secondaryAnimation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: PatientDetailPage(
                patientId: patient.patientId,
                authToken: widget.authToken,
                patient: patient,
                residentId: widget.residentId,
              ),
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffE3F9FF),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 0, right: 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: selectBoxDecor,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 22
                          ),
                          controller: _searchController,
                          onChanged: (query) => setState(() {
                            _filterPatients(query);
                          }),
                          decoration: InputDecoration(
                            labelText: 'Search patient by name or ID',
                            prefixIcon: const Icon(Icons.search),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            const SizedBox(
              height: 20,
            ),
                if (_isSearching) ...[
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _filteredPatients.map((patient) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _onPatientSelected(patient);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 10),
                                  ),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 300,
                                  width: _calculateContainerWidth(context),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: const Color(0xff99e9ff),
                                  ),
                                  child: const Image(
                                    image: AssetImage('asset/patient.png'),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            patient.patientId,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50, // You can adjust the font size as needed
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            'Patient Name: ${patient.patient_fName} ${patient.patient_lName}',
                                            style: const TextStyle(
                                              fontSize: 36, // You can adjust the font size as needed
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Sex: ${patient.patient_sex}',
                                                style: const TextStyle(
                                                  fontSize:
                                                  36, // You can adjust the font size as needed
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                'Age: ${patient.patient_age.toString()}',
                                                style: const TextStyle(
                                                  fontSize:
                                                  36, // You can adjust the font size as needed
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

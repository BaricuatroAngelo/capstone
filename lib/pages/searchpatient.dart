// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:capstone/design/containers/containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/constants.dart';
import 'AddPatient.dart';
import 'Models/Patient/patient.dart';
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
  late SortType _sortType = SortType.Name;
  bool _isNameAscending = true;
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/patients');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      print('Request URL: ${url.toString()}');
      print('Request Headers: ${response.request?.headers}');

      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _patients =
              responseData.map((data) => Patient.fromJson(data)).toList();
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

  void _sortData(SortType sortType) {
    setState(() {
      if (_sortType == sortType) {
        _isNameAscending = !_isNameAscending;
      } else {
        _isNameAscending = true;
      }
      _sortType = sortType;

      _filteredPatients.sort((a, b) {
        int compare;
        if (sortType == SortType.Name) {
          compare = a.firstName.compareTo(b.firstName);
        } else if (sortType == SortType.ID) {
          compare = a.patientId.compareTo(b.patientId);
        } else {
          compare = 0;
        }
        return _isNameAscending ? compare : -compare;
      });
    });
  }

  void _filterPatients(String query) {
    setState(() {
      _filteredPatients = _patients.where((patient) {
        final fullName =
            '${patient.firstName} ${patient.lastName}'.toLowerCase();
        return fullName.contains(query.toLowerCase()) ||
            patient.patientId.toLowerCase().contains(query.toLowerCase()) ||
            patient.sex.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _applyFilter(String filterType) {
    if (filterType == 'Name') {
      _sortData(SortType.Name);
    } else if (filterType == 'Patient ID') {
      _sortData(SortType.ID);
    }
  }

  void _onPatientSelected(Patient patient) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          // Set the duration of the transition
          pageBuilder: (context, animation, secondaryAnimation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: PatientInfoPage(
                patientId: patient.patientId,
                authToken: widget.authToken,
              ),
            );
          },
        ),
      );
    });
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
        body: Padding(
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
                        controller: _searchController,
                        onChanged: (query) => _filterPatients(query),
                        decoration: InputDecoration(
                          labelText: 'Search patient by name or ID',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.filter_list),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Sort By'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: const Text('ID'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _applyFilter('Patient ID');
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('Name'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _applyFilter('Name');
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('Sex'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _applyFilter('Sex');
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
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
              space,
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        const DataColumn(label: Text('Patient ID')),
                        const DataColumn(label: Text('Name')),
                        const DataColumn(label: Text('Sex')),
                        const DataColumn(label: Text('Vaccination Status')),
                        const DataColumn(label: Text('Age')),
                      ],
                      rows: _filteredPatients.map((patient) {
                        return DataRow(cells: [
                          DataCell(
                            Text(patient.patientId),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              _onPatientSelected(patient);
                            },
                          ),
                          DataCell(
                            Text('${patient.firstName} ${patient.lastName}'),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              _onPatientSelected(patient);
                            },
                          ),
                          DataCell(
                            Text(patient.sex),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              _onPatientSelected(patient);
                            },
                          ),
                          DataCell(
                            Text(patient.vaccinationStatus),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              _onPatientSelected(patient);
                            },
                          ),
                          DataCell(
                            Text(patient.age.toString()),
                            onTap: (){
                              FocusScope.of(context).unfocus();
                              _onPatientSelected(patient);
                            }
                          )
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddPatientPage(authToken: widget.authToken)),
            );
          },
          tooltip: 'Add Patient',
          backgroundColor: const Color(0xff66d0ed),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
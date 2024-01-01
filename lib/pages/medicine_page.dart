import 'package:capstone/pages/patientMeds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/patient.dart';
import 'Models/Patient/patientMedicine.dart';
import 'Models/medicine.dart';

class MedicineSelectionPage extends StatefulWidget {
  final String authToken;
  final String patientId;
  final Patient patient;

  const MedicineSelectionPage(
      {super.key, required this.authToken,
      required this.patientId,
      required this.patient});

  @override
  _MedicineSelectionPageState createState() => _MedicineSelectionPageState();
}

class _MedicineSelectionPageState extends State<MedicineSelectionPage> {
  List<Medicine> _medicineOptions = [];
  List<PatientMedicine> _patientMedicines = [];
  Medicine? _selectedMedicine;
  String? _selectedFrequency;

  @override
  void initState() {
    super.initState();
    fetchMedicineOptions();
    fetchPatientMedicines();
  }

  Future<void> storeSelectedMedicine() async {
    if (_selectedMedicine != null && _selectedFrequency != null) {
      final url = Uri.parse(
          '${Env.prefix}/api/patientMedicines'); // Replace with your API URL.
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
        body: {
          'patient_id': widget.patientId,
          'medicine_id': _selectedMedicine!.medicineId,
          'patientMedicineDate': DateTime.now().toString(),
          'medicine_frequency': _selectedFrequency!,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _selectedMedicine = null;
          _selectedFrequency = null;
        });
      } else {
        // Handle API error
        print(response.body);
        print(response.statusCode);
        print('Failed to add selected medicine');
      }
    }
  }

  Future<void> fetchPatientMedicines() async {
    final url = Uri.parse(
        '${Env.prefix}/api/patientMedicines'); // Replace with your API URL.
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${widget.authToken}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<PatientMedicine> patientMedicines=
          responseData.map((data) => PatientMedicine.fromJson(data)).toList();
      final List<PatientMedicine> filteredMedicines =
      patientMedicines.where((medicine) => medicine.patientId == widget.patientId).toList();
      setState(() {
        _patientMedicines = filteredMedicines;
      });
    } else {
      // Handle API error
      print('Failed to fetch patient medicines');
    }
  }

  void viewPatientMedicine() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientMedicineListPage(
          patientMedicines: _patientMedicines,
          patientId: widget.patientId,
          patient: widget.patient,
          medicinesList: _medicineOptions,
        ),
      ),
    );
  }

  Medicine getMedicineById(String medicineId) {
    final medicine = _medicineOptions.firstWhere(
      (medicine) => medicine.medicineId == medicineId,
      orElse: () => Medicine(
        // Provide default values here
        medicineId: 'Unknown',
        medicineName: 'Unknown',
        medicineBrand: 'Unknown',
        medicineDosage: 'Unknown',
        medicineType: 'Unknown',
        medicinePrice: 'Unknown',
      ),
    );
    return medicine;
  }

  Future<void> fetchMedicineOptions() async {
    final url =
        Uri.parse('${Env.prefix}/api/medicines'); // Replace with your API URL.
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${widget.authToken}'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final medicines = data.map((json) => Medicine.fromJson(json)).toList();

      medicines.sort((a, b) => a.medicineType.compareTo(b.medicineType));

      setState(() {
        _medicineOptions = medicines;
      });
    } else {
      // Handle API error
      print('Failed to fetch medicine options');
    }
  }

  Future<void> reloadPage() async {
    await fetchPatientMedicines();
    setState(() {}); // Trigger a rebuild of the UI
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xffE3F9FF),
        appBar: AppBar(
          backgroundColor: const Color(0xff66d0ed),
          elevation: 2,
          toolbarHeight: 80,
          title: Padding(
              padding: EdgeInsets.only(left: (screenWidth - 400) / 2),
              child: const Text(
                'Medicine Selection',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
          actions: [
            IconButton(
                onPressed: () {
                  reloadPage();
                },
                icon: const Icon(
                  Icons.refresh,
                  size: 30,
                )),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 600,
              width: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Image(
                        image: AssetImage('asset/ipimslogo.png'),
                      height: 250,
                      width: 250,
                      ),
                    ),
                  const SizedBox(height: 10,),
                  DropdownButton<Medicine>(
                    hint: const Text(
                      'Select a medicine',
                      style: TextStyle(fontSize: 24),
                    ),
                    value: _selectedMedicine,
                    items: _medicineOptions.map((medicine) {
                      final isSelected = medicine == _selectedMedicine;
                      final itemStyle = isSelected
                          ? const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            )
                          : null;

                      return DropdownMenuItem<Medicine>(
                        value: medicine,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  medicine.medicineName,
                                  style: itemStyle,
                                ),
                                Text(
                                  medicine.medicineType,
                                  style: itemStyle,
                                )
                              ],
                            ),
                            Text(
                              '${medicine.medicineBrand} ${medicine.medicineDosage}',
                              style: isSelected
                                  ? const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    )
                                  : const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMedicine = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _selectedMedicine != null
                          ? '${_selectedMedicine!.medicineName} (${_selectedMedicine!.medicineDosage}, ${_selectedMedicine!.medicineType})'
                          : 'Selected Medicine: ',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    hint: const Text(
                      'Select frequency',
                      style: TextStyle(fontSize: 20),
                    ),
                    value: _selectedFrequency,
                    items: <String>[
                      'daily',
                      'every other day',
                      'BID/b.i.d. (twice a day)',
                      'TID/t.id. (three times a day)',
                      'QID/q.i.d. (four times a day)',
                      'QHS (every bedtime)',
                      'Q4h (every 4 hours)',
                      'Q4-6h (every 4 to 6 hours)',
                      'QWK (every week)',
                    ].map((frequency) {
                      return DropdownMenuItem<String>(
                        value: frequency,
                        child: Text(frequency),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFrequency = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _selectedFrequency != null
                        ? '$_selectedFrequency'
                        : 'Selected Frequency:',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          storeSelectedMedicine();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ), backgroundColor: const Color(0xff66d0ed),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                        ),
                        child: const Text('Add Selected Medicine'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          viewPatientMedicine();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ), backgroundColor: const Color(0xff66d0ed),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                        ),
                        child: const Text('View Patient Medicine'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

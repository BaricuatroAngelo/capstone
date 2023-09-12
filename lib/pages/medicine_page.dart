import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/design/containers/text.dart';
import 'package:capstone/pages/Models/Patient/EHR.dart';
import 'package:capstone/pages/selectedMeds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/patientMedicine.dart';
import 'Models/medicine.dart';

class MedicineSelectionPage extends StatefulWidget {
  final String authToken;
  final String patientId;
  final PatientHealthRecord patient;

  MedicineSelectionPage(
      {required this.authToken,
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

  String generatePatientMedicineId(int currentIndex) {
    const prefix = 'PM';

    final numericPart = (currentIndex + 1).toString();

    final paddingLength = 2 - numericPart.length;

    final paddedNumericPart = '0' * paddingLength + numericPart;

    final patientMedicineId = '$prefix$paddedNumericPart';

    return patientMedicineId;
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
      final data = jsonDecode(response.body) as List<dynamic>;
      final patientMedicines =
          data.map((json) => PatientMedicine.fromJson(json)).toList();

      setState(() {
        _patientMedicines = patientMedicines;
      });
    } else {
      // Handle API error
      print('Failed to fetch patient medicines');
    }
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
              icon: const Icon(Icons.refresh, size: 30,)),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<Medicine>(
                hint: const Text('Select a medicine'),
                value: _selectedMedicine,
                items: _medicineOptions.map((medicine) {
                  final isSelected = medicine == _selectedMedicine;
                  final itemStyle = isSelected
                      ? const TextStyle(
                          color: Colors
                              .grey, // Set the color to grey for selected item
                        )
                      : null; // Null style for unselected items

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
                                  fontSize: 12,
                                  color: Colors.grey,
                                )
                              : const TextStyle(
                                  fontSize: 12, color: Colors.grey),
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
              const SizedBox(height: 20),
              Text(
                _selectedMedicine != null
                    ? 'Selected Medicine: ${_selectedMedicine!.medicineBrand} ${_selectedMedicine!.medicineName} (${_selectedMedicine!.medicineDosage}, ${_selectedMedicine!.medicineType})'
                    : 'Selected Medicine: ',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                hint: const Text('Select frequency'),
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
              const SizedBox(height: 20),
              Text(
                _selectedFrequency != null
                    ? 'Selected Frequency: $_selectedFrequency'
                    : 'Selected Frequency:',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Patient Medicines:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 200,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: _patientMedicines.length,
                    itemBuilder: (context, index) {
                      final patientMedicine = _patientMedicines[index];
                      final medicine =
                          getMedicineById(patientMedicine.medicineId);

                      return ListTile(
                        title: Text(medicine.medicineName),
                        trailing: Text(medicine.medicineType),
                        subtitle: Text(patientMedicine.medicineFrequency),
                        // Customize the list item as needed.
                      );
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  storeSelectedMedicine();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  primary: const Color(0xff66d0ed),
                ),
                child: const Text('Add Selected Medicine'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

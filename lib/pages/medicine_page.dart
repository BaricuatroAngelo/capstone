import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/design/containers/text.dart';
import 'package:capstone/pages/Models/Patient/EHR.dart';
import 'package:capstone/pages/selectedMeds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../design/containers/widgets/urlWidget.dart';
import 'Models/medicine.dart';

class MedicineSelectionPage extends StatefulWidget {
  final String authToken; // You'll need to pass the auth token here.
  final String patientId;
  final PatientHealthRecord patient;
  MedicineSelectionPage(
      {required this.authToken, required this.patientId, required this.patient});

  @override
  _MedicineSelectionPageState createState() => _MedicineSelectionPageState();
}

class _MedicineSelectionPageState extends State<MedicineSelectionPage> {
  List<Medicine> _medicineOptions = [];
  Medicine? _selectedMedicine;
  String? _selectedFrequency;

  @override
  void initState() {
    super.initState();
    fetchMedicineOptions();
  }

  String generatePatientMedicineId(int currentIndex) {
    // Define a prefix (e.g., "PM")
    final prefix = 'PM';

    // Generate the numeric part by incrementing currentIndex by 1
    final numericPart = (currentIndex + 1).toString();

    // Calculate the padding length based on your desired length (e.g., 2 for double digits)
    final paddingLength = 2 - numericPart.length;

    // Create the numeric part with leading zeros if needed
    final paddedNumericPart = '0' * paddingLength + numericPart;

    // Combine the prefix and numeric part to form the patientMedicine_id
    final patientMedicineId = '$prefix$paddedNumericPart';

    return patientMedicineId;
  }

  Future<void> storeSelectedMedicine() async {
    if (_selectedMedicine != null && _selectedFrequency != null) {
      final url = Uri.parse('${Env.prefix}/api/patientMedicines'); // Replace with your API URL.
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
        // Medicine added successfully
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

  Future<void> fetchMedicineOptions() async {
    final url = Uri.parse('${Env.prefix}/api/medicines'); // Replace with your API URL.
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${widget.authToken}'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final medicines = data.map((json) => Medicine.fromJson(json)).toList();
      setState(() {
        _medicineOptions = medicines;
      });
    } else {
      // Handle API error
      print('Failed to fetch medicine options');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Selection'),
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
                    color: Colors.grey, // Set the color to grey for selected item
                  )
                      : null; // Null style for unselected items

                  return DropdownMenuItem<Medicine>(
                    value: medicine,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medicine.medicineName,
                          style: itemStyle,
                        ),
                        Text(
                          '${medicine.medicineBrand} ${medicine.medicineDosage}',
                          style: isSelected
                              ? TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          )
                              : const TextStyle(fontSize: 12, color: Colors.grey),
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
                _selectedMedicine != null
                    ? 'Selected Medicine: ${_selectedMedicine!.medicineBrand} ${_selectedMedicine!.medicineName} (${_selectedMedicine!.medicineDosage})'
                    : 'No medicine selected',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                _selectedFrequency != null
                    ? 'Selected Frequency: $_selectedFrequency'
                    : 'No frequency selected',
                style: const TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () {
                  storeSelectedMedicine();
                },
                child: const Text('Add Selected Medicine'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
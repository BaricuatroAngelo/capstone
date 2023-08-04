import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/design/containers/text.dart';
import 'package:capstone/pages/selectedMeds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Models/medicine.dart';

class MedicineSelectionPage extends StatefulWidget {
  const MedicineSelectionPage({super.key});

  @override
  MedicineSelectionPageState createState() => MedicineSelectionPageState();
}

class MedicineSelectionPageState extends State<MedicineSelectionPage> {
  List<Medicine> _medicineOptions = [];
  final List<Medicine> _selectedMedicines = [];

  @override
  void initState() {
    super.initState();
    fetchMedicineOptions();
  }

  Future<void> fetchMedicineOptions() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/medicines');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<Medicine> medicineOptions = [];

      for (var medicine in data) {
        medicineOptions.add(Medicine.fromJson(medicine));
      }

      setState(() {
        _medicineOptions = medicineOptions;
      });
    }
  }

  Future<void> postSelectedMedicines() async {
    if (_selectedMedicines.isNotEmpty) {
      final url = Uri.parse('http://10.0.2.2:8000/api/InfoMedicine');

      try {
        final List<Map<String, dynamic>> selectedMedicinesData = [];

        for (var medicine in _selectedMedicines) {
          selectedMedicinesData.add({
            'infomedicine_id': 'your-generated-id-here',
            // Generate a unique ID for each info_medicine entry
            'medicine_id': medicine.medicineId,
            // Replace 'medicineId' with the actual property name from the Medicine model
          });
        }

        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(selectedMedicinesData),
        );

        if (response.statusCode == 200) {
          // Selected medicines posted successfully
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Selected medicines posted successfully!'),
            ),
          );
        } else {
          // Error posting selected medicines
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Failed to post selected medicines. Please try again.'),
            ),
          );
        }
      } catch (e) {
        // Error occurred
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again later.'),
          ),
        );
      }
    }
  }

  void selectMedicine(Medicine selectedMedicine) {
    bool isAlreadySelected = _selectedMedicines.contains(selectedMedicine);
    if (!isAlreadySelected) {
      setState(() {
        _selectedMedicines.add(selectedMedicine);
      });
    }
  }

  void removeMedicine(Medicine medicine) {
    setState(() {
      _selectedMedicines.remove(medicine);
    });
  }

  // void navigateToNextPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           SelectedMeds(selectedMedicines: _selectedMedicines),
  //     ),
  //   );
  // }

  void clearAllMedicines() {
    setState(() {
      _selectedMedicines.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3f9ff),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                        titleText,
                        Icon(Icons.menu),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 400,
                      decoration: selectBoxDecor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton<Medicine>(
                          hint: const Text('Select a medicine'),
                          value: null,
                          onChanged: (selectedMedicine) {
                            if (selectedMedicine != null) {
                              selectMedicine(selectedMedicine);
                            }
                          },
                          items: _medicineOptions
                              .where((medicine) =>
                                  !_selectedMedicines.contains(medicine))
                              .map((medicine) {
                            return DropdownMenuItem<Medicine>(
                              value: medicine,
                              child: Column(
                                children: [
                                  Text(medicine.medicineName),
                                  Text(medicine.medicineDosage),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 650,
                decoration: selectBoxDecor,
                child: _selectedMedicines.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: _selectedMedicines.length,
                        itemBuilder: (context, index) {
                          final medicine = _selectedMedicines[index];
                          return ListTile(
                            title: Text(
                              medicine.medicineName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              medicine.medicineBrand,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                removeMedicine(medicine);
                              },
                            ),
                          );
                        },
                      )
                    : centerTexts,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: updateButton,
                  ),
                  InkWell(
                    onTap: () {},
                    child: clearButton,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

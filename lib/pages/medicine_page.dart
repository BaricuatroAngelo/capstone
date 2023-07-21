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

  void navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultsPage(selectedMedicines: _selectedMedicines),
      ),
    );
  }

  void clearAllMedicines() {
    setState(() {
      _selectedMedicines.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3f9ff),
      appBar: AppBar(
        title: const Text('Medicine Selection'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    titleText,
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff99e9ff).withOpacity(0.4),
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
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
                              child: Text(medicine.medicineName),
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
                height: 570,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff99e9ff).withOpacity(0.4),
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: _selectedMedicines.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: _selectedMedicines.length,
                        itemBuilder: (context, index) {
                          final medicine = _selectedMedicines[index];
                          return ListTile(
                            title: Text(
                              medicine.medicineName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              medicine.medicineBrand,
                              style: const TextStyle(fontWeight: FontWeight.w500),
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
                    onTap:
                        _selectedMedicines.isEmpty ? null : navigateToNextPage,
                    child: updateButton,
                  ),
                  InkWell(
                    onTap:
                        _selectedMedicines.isEmpty ? null : clearAllMedicines,
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

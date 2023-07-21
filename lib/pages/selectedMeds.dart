import 'package:capstone/design/containers/text.dart';
import 'package:flutter/material.dart';

import 'Models/medicine.dart';

class ResultsPage extends StatelessWidget {
  final List<Medicine> selectedMedicines;

  const ResultsPage({super.key, required this.selectedMedicines});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3f9ff),
      appBar: AppBar(
        title: const Text('Selected Medicines'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText,
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: selectedMedicines.length,
                  itemBuilder: (context, index) {
                    final medicine = selectedMedicines[index];
                    return ListTile(
                      title: Text(
                        medicine.medicineName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        medicine.medicineBrand,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


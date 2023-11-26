import 'package:flutter/material.dart';
import 'Models/Patient/patientMedicine.dart';
import 'Models/medicine.dart';

class PatientMedicineListPage extends StatelessWidget {
  final List<PatientMedicine> patientMedicines;

  PatientMedicineListPage({required this.patientMedicines});

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
      ),
      body: ListView.builder(
        itemCount: patientMedicines.length,
        itemBuilder: (context, index) {
          final patientMedicine = patientMedicines[index];
          // Retrieve the Medicine object for the patientMedicine
          // You might have to pass the list of Medicines too
          // Then, retrieve the medicine details based on patientMedicine.medicineId
          // You can utilize getMedicineById from your previous code
          // and display the medicine details in ListTile or any other widget
          // Example:
          // final medicine = getMedicineById(patientMedicine.medicineId);

          return ListTile(
            title: Text(
              'Medicine Name: ${patientMedicine.medicineId}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Josefin Sans',
              ),
            ), // Replace with actual medicine details
            subtitle: Text('Frequency: ${patientMedicine.medicineFrequency}'),
          );
        },
      ),
    );
  }
}

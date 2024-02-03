import 'package:flutter/material.dart';
import 'Models/Patient/patient.dart';
import 'Models/Patient/patientMedicine.dart';
import 'Models/medicine.dart';

class PatientMedicineListPage extends StatelessWidget {
  final List<PatientMedicine> patientMedicines;
  final List<Medicine> medicinesList;
  final String patientId;
  final Patient patient;

  const PatientMedicineListPage({super.key, 
    required this.patientMedicines,
    required this.patientId,
    required this.patient,
    required this.medicinesList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 2,
        toolbarHeight: 80,
        title: Center(
          child: Text(
            '$patientId Selected Medicine',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: patientMedicines.isEmpty ?
          const Center(
            child: Text(
              'Patient has yet to take medications',
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey,
              ),
            ),
          ) : ListView.builder(
        itemCount: patientMedicines.length,
        itemBuilder: (context, index) {
          final patientMedicine = patientMedicines[index];
          Medicine? medicine = medicinesList.firstWhere(
                (medicine) => medicine.medicineId == patientMedicine.medicineId,
            orElse: () => Medicine(
              medicineId: '',
              medicineName: 'Unknown Medicine',
              medicineBrand: 'Unknown Brand',
              medicineDosage: 'Unknown Dosage',
              medicinePrice: 'Unknown Price',
              medicineType: 'Unknown Type',
            ),
          );

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(
                Icons.medical_services,
                size: 40,
                color: Colors.blue,
              ),
              title: Text(
                medicine.medicineName ?? 'Unknown Medicine',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequency: ${patientMedicine.medicineFrequency}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Type: ${medicine.medicineType ?? 'Unknown Type'}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  // Add functionality to show more medicine details
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

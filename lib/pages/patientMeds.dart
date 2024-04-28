import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Models/Patient/patient.dart';
import 'Models/Patient/patientMedicine.dart';
import 'Models/medicine.dart';

class PatientMedicineListPage extends StatefulWidget {
  final List<PatientMedicine> patientMedicines;
  final List<Medicine> medicinesList;
  final String patientId;
  final Patient patient;

  const PatientMedicineListPage({
    Key? key,
    required this.patientMedicines,
    required this.patientId,
    required this.patient,
    required this.medicinesList,
  }) : super(key: key);

  @override
  _PatientMedicineListPageState createState() => _PatientMedicineListPageState();
}

class _PatientMedicineListPageState extends State<PatientMedicineListPage> {
  void _showMedicineDetails(Medicine medicine, PatientMedicine patientMedicine) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(medicine.medicineName ?? 'Unknown Medicine'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Brand: ${medicine.medicineBrand ?? "Unknown Brand"}'),
              Text('Dosage: ${medicine.medicineDosage ?? "Unknown Dosage"}'),
              Text('Price: ${medicine.medicinePrice ?? "Unknown Price"}'),
              Text('Type: ${medicine.medicineType ?? "Unknown Type"}'),
              Text(
                'Frequency: ${patientMedicine.medicineFrequency}',
              ),
              Text(
                'End Date: ${patientMedicine.patientMedicineDate != null ? DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.parse(patientMedicine.patientMedicineDate!)) : "Unknown"}',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

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
            '${widget.patientId} Selected Medicine',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: widget.patientMedicines.isEmpty
          ? const Center(
              child: Text(
                'Patient has yet to take medications',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: widget.patientMedicines.length,
              itemBuilder: (context, index) {
                final patientMedicine = widget.patientMedicines[index];
                final medicine = widget.medicinesList.firstWhere(
                  (m) => m.medicineId == patientMedicine.medicineId,
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
                    tileColor: Colors.white,
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
                          'Type: ${medicine.medicineType ?? "Unknown Type"}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'End Date: ${patientMedicine.patientMedicineDate != null ? DateTime.now().isAfter(DateTime.parse(patientMedicine.patientMedicineDate!)) ? "MEDICATION ENDED" : DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.parse(patientMedicine.patientMedicineDate!)) : "Unknown Type"}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showMedicineDetails(medicine, patientMedicine);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

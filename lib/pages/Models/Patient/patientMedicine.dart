class PatientMedicine {
  final String patientMedicineId;
  final String patientMedicineDate;
  final String medicineFrequency;
  final String medicineId;
  final String patientId;

  PatientMedicine({
    required this.patientMedicineId,
    required this.patientMedicineDate,
    required this.medicineFrequency,
    required this.medicineId,
    required this.patientId,
});

  factory PatientMedicine.fromJson(Map<String, dynamic> json) {
    return PatientMedicine(
      patientMedicineId: json['patientMedicine_id'],
      patientMedicineDate: json['patientMedicineDate'],
      medicineFrequency: json['medicine_frequency'],
      medicineId: json['medicine_id'],
      patientId: json['patient_id']
    );
  }
}
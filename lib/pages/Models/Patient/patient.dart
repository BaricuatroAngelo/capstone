class Patient {
  final String patient_id;
  final String patient_fName;
  final String patient_mName;
  final String patient_lName;
  final int patient_age;
  final String patient_sex;

  Patient({
    required this.patient_id,
    required this.patient_fName,
    required this.patient_mName,
    required this.patient_lName,
    required this.patient_age,
    required this.patient_sex,
});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patient_id: json['patient_id'],
      patient_fName: json['patient_fName'],
      patient_mName: json['patient_mName'],
      patient_lName: json['patient_lName'],
      patient_age: json['patient_age'],
      patient_sex: json['patient_sex'],
    );
  }
}
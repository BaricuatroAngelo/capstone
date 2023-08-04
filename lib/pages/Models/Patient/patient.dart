import 'dart:convert';

import 'package:http/http.dart' as http;

class Patient {
  final String patientId;
  final String firstName;
  final String lastName;
  final String middleName;
  final int age;
  final String sex;
  final String vaccinationStatus;

  Patient({
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.age,
    required this.sex,
    required this.vaccinationStatus,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientId: json['patient_id'],
      firstName: json['patient_fName'],
      lastName: json['patient_lName'],
      middleName: json['patient_mName'],
      age: int.parse(json['patient_age']),
      sex: json['patient_sex'],
      vaccinationStatus: json['patient_vaccination_stat'],
    );
  }
}

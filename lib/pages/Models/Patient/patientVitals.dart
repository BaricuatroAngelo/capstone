class PatientVitals {
  final String patientVitalsId;
  final String patientVitalsDate;
  final int patientBp;
  final int patientTemp;
  final int patientPulseRate;
  final int patientBreathingRate;
  final String patientId;

  PatientVitals({
    required this.patientVitalsId,
    required this.patientVitalsDate,
    required this.patientBp,
    required this.patientTemp,
    required this.patientPulseRate,
    required this.patientBreathingRate,
    required this.patientId,
  });

  factory PatientVitals.fromJson(Map<String, dynamic> json) {
    return PatientVitals(
      patientVitalsId: json['patientVitals_id'],
      patientVitalsDate: json['patientVitals_date'],
      patientBp: json['patient_bp'],
      patientTemp: json['patient_temp'],
      patientPulseRate: json['patient_pulseRate'],
      patientBreathingRate: json['patient_breathingRate'],
      patientId: json['patient_id'],
    );
  }
}

class PatientHistory {
  final String patientHistoryId;
  final DateTime patientHistoryDate;
  final String patientLogId;
  final String patientId;

  PatientHistory({
    required this.patientHistoryId,
    required this.patientHistoryDate,
    required this.patientLogId,
    required this.patientId,
  });

  factory PatientHistory.fromJson(Map<String, dynamic> json) {
    return PatientHistory(
      patientHistoryId: json['patientHistory_id'],
      patientHistoryDate: DateTime.parse(json['patientHistory_date']),
      patientLogId: json['patientLog'],
      patientId: json['patient_id'],
    );
  }
}

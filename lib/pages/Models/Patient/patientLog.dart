class PatientLog {
  final String patientLogId;
  final String patientLogDate;
  final String patientId;
  final String pInfoId;

  PatientLog({
    required this.patientLogId,
    required this.patientLogDate,
    required this.patientId,
    required this.pInfoId,
  });

  factory PatientLog.fromJson(Map<String, dynamic> json) {
    return PatientLog(
      patientLogId: json['patientLog_id'],
      patientLogDate: json['patientLog_date'],
      patientId: json['patient_id'],
      pInfoId: json['pInfo_id'],
    );
  }
}

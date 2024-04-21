class ResAssPat {
  final String rapId;
  final int isMainResident;
  final String residentId;
  final String patientId;

  ResAssPat({
    required this.rapId,
    required this.isMainResident,
    required this.residentId,
    required this.patientId,
});

  factory ResAssPat.fromJson(Map<String, dynamic> json) {
    return ResAssPat(
      rapId: json['RAP_id'],
      isMainResident: json['isMainResident'],
      residentId: json['resident_id'],
      patientId: json['patient_id'],
    );
  }
}
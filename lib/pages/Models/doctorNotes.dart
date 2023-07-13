class DoctorNotes {
  final String notes;
  final String pInfoId;
  final String residentId;

  DoctorNotes({
    required this.notes,
    required this.pInfoId,
    required this.residentId,
  });

  factory DoctorNotes.fromJson(Map<String, dynamic> json) {
    return DoctorNotes(
        notes: json['notes'],
        pInfoId: json['pInfo_id'],
        residentId: json['resident_id']);
  }
}

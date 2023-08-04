class DoctorNotes {
  final String docNotesId;
  final String notes;
  final String pInfoId;
  final String residentId;

  DoctorNotes({
    required this.docNotesId,
    required this.notes,
    required this.pInfoId,
    required this.residentId,
  });

  factory DoctorNotes.fromJson(Map<String, dynamic> json) {
    return DoctorNotes(
        docNotesId: json['docNotes_id'],
        notes: json['notes'],
        pInfoId: json['pInfo_id'],
        residentId: json['resident_id']);
  }
}

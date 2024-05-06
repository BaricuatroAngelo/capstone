class patAssRooms {
  final String parId;
  final String patientId;
  final String roomId;
  final bool isDischarged;
  final String dischargeDate;

  patAssRooms({
    required this.parId,
    required this.patientId,
    required this.roomId,
    required this.isDischarged,
    required this.dischargeDate,
});

  factory patAssRooms.fromJson(Map<String, dynamic> json) {
    return patAssRooms(
      parId: json['par_id'],
      patientId: json['patient_id'],
      roomId: json['room_id'],
      isDischarged: json['isDischarged'],
      dischargeDate: json['dischargeDate'],
    );
  }
}
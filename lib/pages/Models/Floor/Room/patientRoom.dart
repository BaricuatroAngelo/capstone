class patAssRooms {
  final String parId;
  final String patientId;
  final String roomId;

  patAssRooms({
    required this.parId,
    required this.patientId,
    required this.roomId,
});

  factory patAssRooms.fromJson(Map<String, dynamic> json) {
    return patAssRooms(
      parId: json['par_id'],
      patientId: json['patient_id'],
      roomId: json['room_id'],
    );
  }
}
class AssignedRoom {
  final String roomId;
  final String residentId;

  AssignedRoom({
    required this.roomId,
    required this.residentId,
  });

  factory AssignedRoom.toJson(Map<String, dynamic> json) {
    return AssignedRoom(
        roomId: json['room_id'], residentId: json['resident_id']);
  }
}

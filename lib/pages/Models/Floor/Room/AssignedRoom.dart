class AssignedRoom {
  final String assignedRoomId;
  final String roomId;
  final String residentId;

  AssignedRoom({
    required this.assignedRoomId,
    required this.roomId,
    required this.residentId,
  });

  factory AssignedRoom.fromJson(Map<String, dynamic> json) {
    return AssignedRoom(
        assignedRoomId: json['resAssRoom_id'],
        roomId: json['room_id'],
        residentId: json['resident_id']);
  }
}

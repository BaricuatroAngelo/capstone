class AssignedRoom {
  final String assignedRoomId;
  final String roomId;
  final String residentId;
  final int isFinished;

  AssignedRoom({
    required this.assignedRoomId,
    required this.roomId,
    required this.residentId,
    required this.isFinished,
  });

  factory AssignedRoom.fromJson(Map<String, dynamic> json) {
    return AssignedRoom(
        assignedRoomId: json['resAssRoom_id'],
        roomId: json['room_id'],
        isFinished: json['isFinished'],
        residentId: json['resident_id']);
  }
}

class Room {
  final String roomId;
  final String roomBuilding;
  final String roomName;
  final String floorId;

  Room({
    required this.roomId,
    required this.roomBuilding,
    required this.roomName,
    required this.floorId,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['room_id'],
      roomBuilding: json['room_building'],
      roomName: json['room_name'],
      floorId: json['floor_id'],
    );
  }
}


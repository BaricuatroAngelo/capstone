class Room {
  final String roomId;
  final String roomName;
  final String roomFloor;
  final String roomType;
  final double roomPrice;
  final String floorId;

  Room({
    required this.roomId,
    required this.roomName,
    required this.roomFloor,
    required this.roomType,
    required this.roomPrice,
    required this.floorId,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['room_id'],
      roomName: json['room_name'],
      roomFloor: json['room_floor'],
      roomType: json['room_type'],
      roomPrice: json['room_price'].toDouble(),
      floorId: json['floor_id'],
    );
  }
}
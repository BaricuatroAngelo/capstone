class Floor {
  final String floorId;
  final String floorName;

  Floor({required this.floorId, required this.floorName});

  factory Floor.fromJson(Map<String, dynamic> json) {
    return Floor(
      floorId: json['floor_id'],
      floorName: json['floor_name'],
    );
  }
}
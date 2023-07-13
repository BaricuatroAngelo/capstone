

class Resident {
  final String residentId;
  final String residentUserName;
  final String residentFName;
  final String residentLName;
  final String residentMName;
  final String residentPassword;
  final String departmentId;

  Resident({
    required this.residentId,
    required this.residentUserName,
    required this.residentFName,
    required this.residentLName,
    required this.residentMName,
    required this.residentPassword,
    required this.departmentId,
  });

  factory Resident.fromJson(Map<String, dynamic> json) {
    return Resident(
      residentId: json['resident_id'],
      residentUserName: json['resident_userName'],
      residentFName: json['resident_fName'],
      residentLName: json['resident_lName'],
      residentMName: json['resident_mName'],
      residentPassword: json['resident_password'],
      departmentId: json['department_id'],
    );
  }
}
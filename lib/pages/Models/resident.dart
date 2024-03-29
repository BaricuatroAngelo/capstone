

class Resident {
  final String residentId;
  final String residentUserName;
  final String residentFName;
  final String residentLName;
  final String residentMName;
  final String residentPassword;
  final String role;
  final String departmentId;
  // final String residentGender;
  // final String createdAt;
  // final String updatedAt;
  // final String rememberToken;

  Resident({
    required this.residentId,
    required this.residentUserName,
    required this.residentFName,
    required this.residentLName,
    required this.residentMName,
    required this.residentPassword,
    required this.role,
    required this.departmentId,
    // required this.residentGender,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.rememberToken
  });

  factory Resident.fromJson(Map<String, dynamic> json) {
    return Resident(
      residentId: json['resident_id'],
      residentUserName: json['resident_userName'] ?? '',
      residentFName: json['resident_fName'] ?? '',
      residentLName: json['resident_lName'] ?? '',
      residentMName: json['resident_mName'] ?? '',
      residentPassword: json['resident_password'] ?? '',
      role: json['role'] ?? '',
      departmentId: json['department_id'],
      // residentGender: json['resident_gender'],
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
      // rememberToken: json['remember_token'] ?? '',
    );
  }

}
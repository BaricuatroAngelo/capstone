

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
      residentId: json['resident_id'] as String,
      residentUserName: json['resident_userName'] as String ?? '',
      residentFName: json['resident_fName'] as String ?? '',
      residentLName: json['resident_lName'] as String ?? '',
      residentMName: json['resident_mName'] as String ?? '',
      residentPassword: json['resident_password'] as String ?? '',
      role: json['role'] as String ?? '',
      departmentId: json['department_id'] as String,
      // residentGender: json['resident_gender'],
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
      // rememberToken: json['remember_token'] ?? '',
    );
  }

}
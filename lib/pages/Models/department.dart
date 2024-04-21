class Department {
  final String departmentId;
  final String departmentName;

  Department({required this.departmentId, required this.departmentName});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      departmentId: json['department_id'],
      departmentName: json['department_name'],
    );
  }
}


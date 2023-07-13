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

// Future<Department> loginAndGetDepartment(String username, String password) async {
//   const url = 'http://10.0.2.2:8000/login/';
//   final response = await http.post(
//     Uri.parse(url),
//     body: {
//       'username': username,
//       'password': password,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     final responseData = json.decode(response.body);
//     return Department.fromJson(responseData);
//   } else {
//     throw Exception('Failed to login and get department');
//   }
// }


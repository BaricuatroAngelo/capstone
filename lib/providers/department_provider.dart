import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../pages/Models/department.dart';

class DepartmentProvider extends ChangeNotifier {
  List<Department> _departments = [];

  List<Department> get departments => _departments;

  Future<void> fetchDepartments() async {
    const apiUrl = 'http://10.0.2.2:8000/api/departments'; // Replace with your API endpoint

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Department> fetchedDepartments = data
          .map((dynamic json) => Department.fromJson(json))
          .toList();

      _departments = fetchedDepartments;
      notifyListeners();
    } else {
      throw Exception('Failed to fetch departments.');
    }
  }
}

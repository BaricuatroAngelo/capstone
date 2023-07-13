import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/department.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Department> departments = [];

  Future<void> fetchDepartments() async {
    const apiUrl = 'http://10.0.2.2:8000/api/departments'; // Replace with your API endpoint

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final List<Department> fetchedDepartments = data
          .map((dynamic json) => Department.fromJson(json))
          .toList();

      setState(() {
        departments = fetchedDepartments;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to fetch departments.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
      ),
      body: ListView.builder(
        itemCount: departments.length,
        itemBuilder: (context, index) {
          final department = departments[index];

          return ListTile(
            title: Text(department.departmentName),
            subtitle: Text(department.departmentId),
          );
        },
      ),
    );
  }
}
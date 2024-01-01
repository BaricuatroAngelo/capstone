import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPatientPage extends StatefulWidget {
  final String authToken;

  const AddPatientPage({super.key, required this.authToken});

  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final TextEditingController _patientIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _vaccineStatController = TextEditingController();

  String _selectedSex = 'M';

  Future<void> _storePatient() async {
    final url = Uri.parse(
        'http://10.0.2.2:8000/api/patients'); // Replace with your Laravel backend URL
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.authToken}'
    };
    Map<String, String> data = {
      'patient_id': _patientIdController.text,
      'patient_fName': _firstNameController.text,
      'patient_lName': _lastNameController.text,
      'patient_mName': _middleNameController.text,
      'patient_age': _ageController.text,
      'patient_sex': _selectedSex,
      'patient_vaccination_stat': _vaccineStatController.text,
    };

    http.Response response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );

    print('Request URL: ${url.toString()}');
    print('Request Headers: ${response.request?.headers}');

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      // If the request is successful, show a success message or perform any desired action.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Patient data saved successfully.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // You can navigate back or perform any other action here.
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // If the request fails, show an error message or perform any desired action.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to save patient data.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // You can handle the error as per your requirement.
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _patientIdController,
              decoration: const InputDecoration(labelText: 'Patient ID'),
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _middleNameController,
              decoration: const InputDecoration(labelText: 'Middle Name'),
            ),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedSex,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSex = newValue!;
                });
              },
              decoration: const InputDecoration(labelText: 'Sex'),
              items: ['M', 'F'].map((String sex) {
                return DropdownMenuItem<String>(
                  value: sex,
                  child: Text(sex),
                );
              }).toList(),
            ),
            TextFormField(
              controller: _vaccineStatController,
              decoration: const InputDecoration(labelText: 'Vaccine Status'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _storePatient,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

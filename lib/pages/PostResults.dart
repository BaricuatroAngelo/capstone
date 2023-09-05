import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Import the date formatting library

import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/EHR.dart';

class LabResultsPage extends StatefulWidget {
  final String authToken;
  final String patientId;
  final PatientHealthRecord patient;
  LabResultsPage({
    required this.authToken,
    required this.patientId,
    required this.patient,
  });

  @override
  _LabResultsPageState createState() => _LabResultsPageState();
}

class _LabResultsPageState extends State<LabResultsPage> {
  TextEditingController labResultDateController = TextEditingController();
  TextEditingController resultsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the labResultDateController with today's date
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    labResultDateController.text = formattedDate;
  }

  Future<void> _submitResults() async {
    final url = Uri.parse('${Env.prefix}/api/results'); // Replace with your API URL

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.authToken}',
      },
      body: {
        'labResultDate': labResultDateController.text,
        'results': resultsController.text,
        'patient_id': widget.patientId,
      },
    );

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Successfully submitted lab results
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lab results submitted successfully!'),
        ),
      );
      // Clear the input fields after successful submission
      resultsController.clear();
    } else {
      // Failed to submit lab results
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit lab results. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              enabled: false,
              controller: labResultDateController,
              decoration: InputDecoration(
                labelText: 'Lab Result Date',
              ),
            ),
            TextFormField(
              controller: resultsController,
              decoration: InputDecoration(
                labelText: 'Results',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitResults,
              child: Text('Submit Results'),
            ),
          ],
        ),
      ),
    );
  }
}

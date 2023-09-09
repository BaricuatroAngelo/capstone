import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/EHR.dart';

class LabResultsPage extends StatefulWidget {
  final String authToken;
  final String patientId;
  final PatientHealthRecord patient;

  const LabResultsPage({
    super.key,
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
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    labResultDateController.text = formattedDate;
  }

  Future<void> _submitResults() async {
    final url =
        Uri.parse('${Env.prefix}/api/results'); // Replace with your API URL

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lab results submitted successfully!'),
        ),
      );
      resultsController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit lab results. Please try again.'),
        ),
      );
    }
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff66d0ed),
          elevation: 2,
          toolbarHeight: 80,
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 30),
              child: Text(
                'Lab Results',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lab Result Date:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                labResultDateController.text,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Results:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 10,
                      offset: const Offset(10, 20),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  // Remove border
                ),
                child: TextFormField(
                  controller: resultsController,
                  maxLines: 8,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _hideKeyboard();
                  _submitResults();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  primary: const Color(0xff66d0ed),
                ),
                child: const Text(
                  'Submit Results',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

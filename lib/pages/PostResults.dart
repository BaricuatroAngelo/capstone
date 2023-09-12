import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/EHR.dart';
import 'Models/results.dart';

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
  String displayedResults = '';
  List<Results> _results = [];

  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    labResultDateController.text = formattedDate;

    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        Uri.parse('${Env.prefix}/api/results'); // Replace with your API URL

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.authToken}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> resultsData = json.decode(response.body);
      final List<Results> results =
          resultsData.map((data) => Results.fromJson(data)).toList();

      setState(() {
        _results = results;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch data. Please try again.'),
        ),
      );
    }
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
      setState(() {
        displayedResults = resultsController.text;
        resultsController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit lab results. Please try again.'),
        ),
      );
    }
  }

  Future<void> reloadPage() async {
    await fetchData();
    setState(() {}); // Trigger a rebuild of the UI
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
          actions: [
            IconButton(
              onPressed: () {
                reloadPage();
              },
              icon: const Icon(
                Icons.refresh,
                size: 30,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    primary: const Color(0xff66d0ed),
                  ),
                  child: const Text(
                    'Submit Results',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Patient ${widget.patient.patientId} Results:',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 500,
                  width: screenWidth,
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
                  ),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final results = _results[index];
                      return ListTile(
                        title: Text(results.results, style: const TextStyle(fontSize: 24),),
                        subtitle: Text(results.labResultDate, style: const TextStyle(fontSize: 24),),
                        trailing: Text(results.patientId, style: const TextStyle(fontSize: 24),),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

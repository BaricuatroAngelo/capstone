import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/patient.dart';
import 'Models/results.dart';

class LabResultsPage extends StatefulWidget {
  final String authToken;
  final String patientId;
  final Patient patient;

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
  List<Results> _results = []; // List to store fetched results
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    labResultDateController.text = formattedDate;

    // Start fetching data every 10 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchData();
    });

    fetchData(); // Fetch initial data
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel(); // Stop the timer when the widget is disposed
  }

  Future<void> fetchData() async {
    final url = Uri.parse('${Env.prefix}/api/results'); // Replace with your API URL

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> resultsData = json.decode(response.body);
        final List<Results> allResults = resultsData.map((data) => Results.fromJson(data)).toList();

        // Filter results to only include those matching the specified patientId
        final List<Results> filteredResults = allResults.where((result) {
          return result.patientId == widget.patientId; // Match the patientId
        }).toList();

        setState(() {
          _results = filteredResults; // Update _results with filtered results
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to fetch lab results.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }

  Future<void> _submitResults() async {
    final url = Uri.parse('${Env.prefix}/api/results'); // Ensure the correct URL

    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(currentDate);

    final labResultText = resultsController.text.trim(); // Trim whitespace

    if (labResultText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter lab results before submitting.'),
          backgroundColor: Colors.red, // Optional: Change color for error messages
        ),
      );
      return; // Early return to avoid sending empty data
    }

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.authToken}',
      },
      body: {
        'labResultDate': formattedDate,
        'results': labResultText, // Use trimmed text
        'patient_id': widget.patientId, // Ensure correct patient ID is submitted
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lab results submitted successfully!'),
        ),
      );
      setState(() {
        resultsController.clear(); // Clear the text field after submission
        fetchData(); // Reload lab results after submission
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit lab results. Please try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Hide keyboard on tap
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff66d0ed),
          elevation: 2,
          toolbarHeight: 80,
          title: const Center(
            child: Text(
              'Lab Results',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
              onPressed: fetchData, // Fetch data when refresh is clicked
              icon: const Icon(
                Icons.refresh,
                size: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lab Result Date:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  labResultDateController.text,
                  style: const TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Lab Results:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.withOpacity(0.6)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.09),
                        blurRadius: 10,
                        offset: const Offset(10, 20),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: resultsController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      hintText: 'Enter lab results',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitResults,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color(0xff66d0ed),
                  ),
                  child: const Text(
                    'Submit Results',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Patient Lab Results:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.withOpacity(0.6)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.09),
                    //     blurRadius: 10,
                    //     offset: const Offset(10, 20),
                    //   ),
                    // ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(), // Smooth scrolling
                    itemCount: _results.length, // Display filtered results
                    itemBuilder: (context, index) {
                      final result = _results[index];
                      return ListTile(
                        title: Text(result.results),
                        subtitle: Text(
                          DateFormat.yMMMEd().format(
                            DateTime.parse(result.labResultDate),
                          ),
                        ),
                        trailing: Text('Patient ID: ${result.patientId}'),
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

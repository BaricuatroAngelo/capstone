import 'package:capstone/pages/PostResults.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultsPage extends StatefulWidget {
  final String patientId;

  const ResultsPage({Key? key, required this.patientId}) : super(key: key);

  @override
  ResultsPageState createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage> {
  String _resultsData = '';

  Future<void> getResults() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/patients/${widget.patientId}/results');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _resultsData = responseData['results_data']; // Assuming 'results_data' is the key in the API response that holds the results for the patient.
        });
      } else {
        // Failed to get results data, you can handle the failure here.
        print('Failed to get results data: ${response.statusCode}');
      }
    } catch (e) {
      // An error occurred, you can handle the error here.
      print('Error fetching results data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3f9ff),
      appBar: AppBar(
        title: const Text('Results Page'),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            top: 30,
            left: 20,
            child: Text(
              'Results Page',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 70, right: 20),
            child: Container(
              height: 600,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: Text(
                  _resultsData.isNotEmpty ? _resultsData : 'No results available for this patient.',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 690, left: 20, right: 20),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PostResultsPage()));
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text('Edit Results'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

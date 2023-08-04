import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostResultsPage extends StatefulWidget {
  const PostResultsPage({Key? key}) : super(key: key);

  @override
  PostResultsPageState createState() => PostResultsPageState();
}

class PostResultsPageState extends State<PostResultsPage> {
  final TextEditingController resultController = TextEditingController();

  Future<void> postResults() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/Results');

    try {
      final result = resultController.text;
      if (result.trim().isEmpty) {
        _showSnackBar('Result cannot be empty');
        return;
      }

      final response = await http.post(
        url,
        body: {
          'result': result,
        },
      );

      print(response.statusCode);

      if (response.statusCode == 201) {
        // Successful post, you can handle the success here.
        _showSnackBar('Result added successfully');
        Navigator.of(context).pop();
      } else {
        // Failed to post results, you can handle the failure here.
        // Show an error message or take appropriate action.
        print(response.statusCode);
        _showSnackBar('Failed to add result. Please try again.');
      }
    } catch (e) {
      // An error occurred, you can handle the error here.
      // Show an error message or take appropriate action.
      print(e);
      _showSnackBar('An error occurred. Please try again later.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        child: TextFormField(
                          controller: resultController,
                          maxLines: null,
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16.0),
                            hintText: 'Type Here...',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 690, left: 20, right: 20),
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  postResults();
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text('OK'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostDocNotesPage extends StatefulWidget{
  const PostDocNotesPage({super.key});

  @override
  PostDocNotesPageState createState() => PostDocNotesPageState();
}

class PostDocNotesPageState extends State<PostDocNotesPage> {
  final TextEditingController _resultsController = TextEditingController();

  Future<void> submitResults() async {
    final String notes = _resultsController.text;

    final url = Uri.parse('http://10.0.2.2:8000/api/doctorNotes');

    try{
      final response = await http.post(url, body: {
        'notes': notes
      });

      final responseData = json.decode(response.body);

      if(response.statusCode == 200) {
        //
      }
    } catch (e){
      //
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff99e9ff),
      ),
    );
  }
}
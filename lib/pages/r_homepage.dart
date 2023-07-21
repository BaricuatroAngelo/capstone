import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Models/Floor/Room/AssignedRoom.dart';
import 'Models/resident.dart';

class HomePage extends StatefulWidget {
  final String residentId;

  const HomePage({Key? key, required this.residentId}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Resident? _resident;
  List<AssignedRoom> _assignedRooms = [];

  @override
  void initState() {
    super.initState();
    _fetchResidentData();
    _fetchAssignedRooms();
  }

  Future<void> _fetchResidentData() async {
    final url =
        Uri.parse('http://10.0.2.2:8000/api/residents/${widget.residentId}');

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final resident = Resident.fromJson(responseData);
        setState(() {
          _resident = resident;
        });
      } else {
        _showSnackBar('Failed to fetch resident data');
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again later.');
    }
  }

  Future<void> _fetchAssignedRooms() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/ResAssRooms/${widget.residentId}');

    try {
      final response = await http.get(url);

      print(response.statusCode);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is List) {
          setState(() {
            _assignedRooms = responseData
                .map((data) => AssignedRoom.fromJson(data))
                .toList();
          });
        } else {
          _showSnackBar('Invalid response data format');
        }
      } else {
        _showSnackBar('Failed to fetch assigned rooms');
      }
    } catch (e) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resident Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome ${_resident?.residentFName ?? ''} ${_resident?.residentLName ?? ''}',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Assigned Rooms:',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _assignedRooms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_assignedRooms[index].assignedRoomId),
                  subtitle: Text('Room ID: ${_assignedRooms[index].roomId}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/Floor/Room/Room.dart';

class ChiefHomePage extends StatefulWidget {
  final String authToken;
  final String residentId;

  const ChiefHomePage(
      {Key? key, required this.residentId, required this.authToken})
      : super(key: key);

  @override
  ChiefHomePageState createState() => ChiefHomePageState();
}

class ChiefHomePageState extends State<ChiefHomePage> {
  late Map<String, List<Room>> _roomsByFloor = {};

  Future<void> _fetchRooms() async {
    final url = Uri.parse(
        'http://10.0.2.2:8000/api/Rooms'); // Replace with your API URL
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<Room> rooms =
            responseData.map((data) => Room.fromJson(data)).toList();

        setState(() {
          _roomsByFloor = _groupRoomsByFloor(rooms);
        });
      } else {
        _showSnackBar('Failed to fetch rooms');
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again later.');
    }
  }

  Map<String, List<Room>> _groupRoomsByFloor(List<Room> rooms) {
    Map<String, List<Room>> groupedRooms = {};

    for (var room in rooms) {
      if (!groupedRooms.containsKey(room.roomFloor)) {
        groupedRooms[room.roomFloor] = [];
      }
      groupedRooms[room.roomFloor]!.add(room);
    }

    return groupedRooms;
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
  void initState() {
    super.initState();
    _fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff66d0ed),
        title: const Center(
          child: Text('Home Page'),
        ),
      ),
      body: _roomsByFloor.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
              child: ListView.builder(
                itemCount: _roomsByFloor.keys.length,
                itemBuilder: (context, index) {
                  String roomFloor = _roomsByFloor.keys.elementAt(index);
                  List<Room> rooms = _roomsByFloor[roomFloor]!;
                  return ExpansionTile(
                    title: Text(
                      roomFloor,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    children: rooms
                        .map((room) => ListTile(
                              title: Text('Room ID: ${room.roomId}'),
                              subtitle: Text('Name: ${room.roomName}'),
                              // Add more details as needed
                            ))
                        .toList(),
                  );
                },
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

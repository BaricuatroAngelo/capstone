import 'dart:convert';

import 'package:capstone/pages/Models/messages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../design/containers/widgets/urlWidget.dart';
import '../Models/resident.dart';

class ChiefMessageRes extends StatefulWidget {
  final String authToken;
  final String residentId;
  final String chatGroupId;
  final Resident selectedResident;

  const ChiefMessageRes({
    Key? key,
    required this.authToken,
    required this.residentId,
    required this.chatGroupId,
    required this.selectedResident,
  }) : super(key: key);

  @override
  State<ChiefMessageRes> createState() => _ChiefMessageResState();
}

class _ChiefMessageResState extends State<ChiefMessageRes> {
  TextEditingController _messageController = TextEditingController();
  List<Messages> messages = [];

  Future<void> _sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.prefix}/api/chatGroupMessages'),
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
        },
        body: {
          'message': message,
          'chatGroup_id': widget.chatGroupId,
          'resident_id': widget.residentId,
        },
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
        reloadPage();
      } else {
        print('Failed to send message: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending message: $error');
    }
  }

  Future<void> _fetchMessages() async {
    try {
      final response = await http.get(
        Uri.parse('${Env.prefix}/api/chatGroupMessages'),
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<Messages> msgs =
        responseData.map((data) => Messages.fromJson(data)).toList();

        // Filter messages based on the residentId and chatGroupId
        msgs.retainWhere((message) =>
        (message.residentId == widget.residentId ||
            message.residentId == widget.selectedResident.residentId) &&
            message.chatGroupId == widget.chatGroupId);

        setState(() {
          messages = msgs;
        });
      }
    } catch (e) {
      print('Exception while fetching messages: $e');
    }
  }


  Future<void> reloadPage() async {
    await _fetchMessages();
    setState(() {}); // Trigger a rebuild of the UI
  }

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color(0xffE3F9FF),
          appBar: AppBar(
            backgroundColor: const Color(0xff66d0ed),
            elevation: 2,
            toolbarHeight: 80,
            title: Padding(
              padding: EdgeInsets.only(left: (screenWidth - 900) / 2),
              child: Text(
                '${widget.selectedResident.residentUserName} Chat',
                style:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isSentByResident =
                        message.residentId == widget.residentId;

                    return Align(
                      alignment: isSentByResident
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: isSentByResident ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          message.messages,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        String message = _messageController.text;
                        _sendMessage(message);
                        _messageController.clear();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

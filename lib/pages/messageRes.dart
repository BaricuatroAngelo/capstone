import 'dart:convert';

import 'package:capstone/pages/Models/messages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../design/containers/widgets/urlWidget.dart';
import 'Models/resident.dart';

class MessageRes extends StatefulWidget {
  final String authToken;
  final String residentId;
  final String chatGroupId;
  final Resident selectedResident;

  const MessageRes({
    Key? key,
    required this.authToken,
    required this.residentId,
    required this.chatGroupId,
    required this.selectedResident,
  }) : super(key: key);

  @override
  State<MessageRes> createState() => _MessageResState();
}

class _MessageResState extends State<MessageRes> {
  final TextEditingController _messageController = TextEditingController();
  List<Messages> messages = [];
  List<Resident> _residents =[];
  List<Resident> _filteredResidents = [];
  bool isLoading = true;

  Future<void> _fetchResidents() async {
    final url = Uri.parse('${Env.prefix}/api/residents');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${widget.authToken}',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(response.body);

        if (responseData is List) {
          setState(() {
            _residents =
                responseData.map((data) => Resident.fromJson(data)).toList();

            // Keep the resident with the provided residentId in _filteredResidents
            _filteredResidents = _residents
                .where((resident) => resident.residentId == widget.residentId)
                .toList();

            // Remove the resident with the provided residentId from _residents
            _residents =
                _residents.where((resident) => resident.residentId != widget.residentId).toList();
          });
        } else {
          _showSnackBar('Invalid response data format');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        _showSnackBar('Failed to fetch patients');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again later.');
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }



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
        await reloadPage(); // Reload messages after sending a new one
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
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<Messages> msgs =
        responseData.map((data) => Messages.fromJson(data)).toList();
        print(widget.residentId);
        print(widget.selectedResident.residentId);
        print(widget.chatGroupId);
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
    _fetchMessages();
    _fetchResidents();
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
            padding: EdgeInsets.only(left: (screenWidth - 350) / 2),
            child: Text(
              '${widget.selectedResident.residentFName} ${widget.selectedResident.residentLName}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  final isSentByResident = message.residentId == widget.residentId;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isSentByResident)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                const SizedBox(width: 50),
                                Text(
                                  widget.selectedResident.residentFName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Row(
                          mainAxisAlignment: isSentByResident
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!isSentByResident)
                              const CircleAvatar(
                                radius: 20,
                                // Placeholder content for the avatar
                                child: Text(
                                  'R', // Initials or image
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            const SizedBox(width: 8),
                            // Display the chat box
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSentByResident ? Colors.blue : Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                message.messages,
                                style: const TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              color: const Color(0xffE3F9FF),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.black, width: 5),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
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
      ),
    );
  }
}

import 'dart:convert';

import 'package:capstone/pages/searchChatGroups.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../design/containers/widgets/urlWidget.dart';
import '../Models/Patient/chatGroupUsers.dart';
import '../Models/resident.dart';
import 'chiefResMessageOther.dart';


class ChiefMessagePage extends StatefulWidget {
  final String authToken;
  final String residentId;

  const ChiefMessagePage({
    Key? key,
    required this.residentId,
    required this.authToken,
  }) : super(key: key);

  @override
  State<ChiefMessagePage> createState() => _ChiefMessagePageState();
}

class _ChiefMessagePageState extends State<ChiefMessagePage> {
  List<chatGroupUsers> _chatGroups = [];
  List<Resident> _residents = [];
  List<Resident> _filteredResidents = [];
  bool isLoading = true;

  Future<void> fetchChatGroup() async {
    final createChatGroupUrl = Uri.parse('${Env.prefix}/api/chatGroupUsers');
    try {
      final response = await http.get(
        createChatGroupUrl,
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
          // Adjust content type if needed
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<chatGroupUsers> chats =
        responseData.map((data) => chatGroupUsers.fromJson(data)).toList();

        // Filtering out chats where residentId matches the current user's residentId
        final filteredChats = chats
            .where((chat) => chat.residentId != widget.residentId)
            .toList();
        setState(() {
          _chatGroups = filteredChats;
        });
      } else {
        // Handle unsuccessful creation
        print('Failed to get chat group: ${response.statusCode}');
        // Optionally, show a message or perform error handling
      }
    } catch (e) {
      // Handle exceptions
      print('Exception while creating chat group: $e');
      // Optionally, show a message or perform error handling
    }
  }

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
            _residents.removeWhere(
                    (resident) => resident.residentId == widget.residentId);
            _filteredResidents = List.from(_residents);
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

  Future<void> _createChatGroup(Resident selectedResident) async {
    final createChatGroupUrl = Uri.parse('${Env.prefix}/api/chatGroupUsers');

    try {
      final response = await http.post(
        createChatGroupUrl,
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
        },
        body: {
          'resident_id': selectedResident.residentId,
          // Use the selected resident's ID
        },
      );
      if (response.statusCode == 200) {
        print('Chat group created!');
        // Optionally, you can update the UI or perform other actions upon successful creation
        reloadPage(); // Reload the chat groups after creating a new one
      } else {
        // Handle unsuccessful creation
        print('Failed to create chat group: ${response.statusCode}');
        // Optionally, show a message or perform error handling
      }
    } catch (e) {
      // Handle exceptions
      print('Exception while creating chat group: $e');
      // Optionally, show a message or perform error handling
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

  void _selectResident() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Resident'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _filteredResidents.map((Resident resident) {
                return ListTile(
                  title: Text(resident.residentUserName),
                  // Replace with the resident property you want to display
                  onTap: () {
                    Navigator.pop(
                        context, resident); // Return the selected resident
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    ).then((selectedResident) {
      if (selectedResident != null) {
        _createChatGroup(selectedResident);
      }
    });
  }

  void navigateToMessageResident(String chatId) {
    chatGroupUsers? selectedChatGroup =
    _chatGroups.firstWhere((group) => group.chatGroupId == chatId);

    String? associatedResidentId = selectedChatGroup.residentId;

    Resident? selectedResident = _residents
        .firstWhere((resident) => resident.residentId == associatedResidentId);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ChiefMessageRes(
        authToken: widget.authToken,
        residentId: widget.residentId,
        chatGroupId: chatId,
        selectedResident: selectedResident,
      ),
    ));
  }

  void navigateToSearch() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchChatPage(
            residentId: widget.residentId, authToken: widget.authToken)));
  }

  Future<void> reloadPage() async {
    await fetchChatGroup();
    setState(() {}); // Trigger a rebuild of the UI
  }

  @override
  void initState() {
    super.initState();
    fetchChatGroup();
    _fetchResidents();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffE3F9FF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff66d0ed),
          elevation: 2,
          toolbarHeight: 80,
          title: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover, // Adjust the fit as needed
                    child: Image.asset('asset/ipimslogo.png'),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Text(
                'Messages',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                navigateToSearch();
              },
            ),
          ],
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            const SizedBox(
              height: 30,
            ),
            _chatGroups.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
              child: ListView.builder(
                itemCount: _chatGroups.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 8),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            'CG',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          'Chat Group ${_chatGroups[index].chatGroupId}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: const Text(
                          'This is a sample message text.',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        trailing: const Text(
                          '12:30 PM', // Replace with the actual timestamp
                          style:
                          TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        onTap: () {
                          navigateToMessageResident(
                              _chatGroups[index].chatGroupId);
                        },
                      ),
                    ),
                  );
                },
              ),
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _selectResident(); // Call method to select a resident
          },
          label: const Text('Create Chat Group'),
          icon: const Icon(Icons.chat_bubble),
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

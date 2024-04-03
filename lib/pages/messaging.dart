import 'dart:async';
import 'dart:convert';

import 'package:capstone/pages/searchChatGroups.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../design/containers/widgets/urlWidget.dart';
import 'Models/Patient/chatGroupUsers.dart';
import 'Models/resident.dart';
import 'messageRes.dart';

class MessagePage extends StatefulWidget {
  final String authToken;
  final String residentId;

  const MessagePage({
    Key? key,
    required this.residentId,
    required this.authToken,
  }) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<chatGroupUsers> _chatGroups = [];
  List<Resident> _residents = [];
  List<Resident> _filteredResidents = [];
  bool isLoading = true;
  late Timer _timer;

  Future<void> fetchChatGroup() async {
    final createChatGroupUrl = Uri.parse('${Env.prefix}/api/chatGroupUsers/get/allGroups');
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
      print('Exception while fetching chat group: $e');
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
            _residents = responseData
                .map((data) => Resident.fromJson(data))
                .toList();

            // Filter out residents who are already in a chat group
            _filteredResidents = _residents
                .where((resident) =>
            !_chatGroups.any((chatGroup) =>
            chatGroup.residentId == resident.residentId) &&
                resident.residentId != widget.residentId) // Exclude current resident
                .toList();
          });
        } else {
          _showSnackBar('Invalid response data format');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        _showSnackBar('Failed to fetch residents');
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
        if (_filteredResidents.isEmpty) {
          return AlertDialog(
            title: const Text('No Residents Found'),
            content: const Text('There are no available residents to select.', style: TextStyle(fontSize: 20),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: const Text('Select Resident'),
            content: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of the screen width
                child: ListBody(
                  children: _filteredResidents.map((Resident resident) {
                    return ListTile(
                      title: Text(resident.residentUserName),
                      onTap: () {
                        Navigator.pop(context, resident); // Return the selected resident
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        }
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
      builder: (context) => MessageRes(
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

  Resident? findResidentById(String residentId) {
    return _residents.firstWhere(
          (resident) => resident.residentId == residentId,
      orElse: () => Resident(residentId: '', residentUserName: '', residentFName: '', residentLName: '', residentPassword: '', role: '', departmentId: '', residentGender: '', isDeleted: 0, departmentName: ''),
    );
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

    // Start the timer to fetch data every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchChatGroup();
      _fetchResidents();
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timer when the widget is disposed
    _timer.cancel();
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
              const SizedBox(width: 20),
              const Text(
                'Messages',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
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
                  final chatGroup = _chatGroups[index];
                  final resident = findResidentById(chatGroup.residentId);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        tileColor: Colors.white,
                        leading: const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.person, // Replace 'CG' with person icon
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          resident != null ? '${resident.residentFName} ${resident.residentLName}' : 'Unknown Resident',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onTap: () {
                          navigateToMessageResident(chatGroup.chatGroupId);
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

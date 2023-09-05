import 'package:flutter/material.dart';

import '../design/containers/containers.dart';

class MessagePage extends StatefulWidget {
  final String authToken;
  final String residentId;

  const MessagePage(
      {Key? key, required this.residentId, required this.authToken})
      : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3F9FF),
      body: Stack(clipBehavior: Clip.none, children: [
        Positioned(
          top: 70,
          left: 40,
          child: Title(
            color: Colors.black,
            child: Text(
              'Messaging',
              style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 150, left: 30, right: 30),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: selectBoxDecor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Search Resident',
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

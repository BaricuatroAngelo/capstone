import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget{
  final String authToken;
  final String residentId;
  const MessagePage({Key? key, required this.residentId, required this.authToken}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  @override
  Widget build(BuildContext context){
    return Container();
  }
}
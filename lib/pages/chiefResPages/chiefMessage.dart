import 'package:flutter/material.dart';

class ChiefMessagePage extends StatefulWidget {
  final String authToken;
  final String residentId;

  const ChiefMessagePage({super.key, required this.authToken, required this.residentId});

  @override
  State<ChiefMessagePage> createState() => ChiefMessagePageState();
}

class ChiefMessagePageState extends State<ChiefMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
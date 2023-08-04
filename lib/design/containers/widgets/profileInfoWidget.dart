
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildProfileInfoTile(String title, String value) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    ),
    trailing: Text(
      value,
      style: const TextStyle(color: Colors.grey, fontSize: 24),
    ),
  );
}
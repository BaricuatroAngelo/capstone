import 'package:flutter/material.dart';

String wrapText(String text, int maxLineLength) {
  if (text.length > maxLineLength) {
    return '${text.substring(0, maxLineLength)}\n${text.substring(maxLineLength)}';
  }
  return text;
}

Widget buildProfileInfoTile(String title, String value, {int maxLineLength = 14}) {
  final wrappedValue = wrapText(value, maxLineLength);

  return ListTile(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    ),
    trailing: Flexible( // Use Flexible to ensure proper behavior
      child: Text(
        wrappedValue,
        style: const TextStyle(color: Colors.grey, fontSize: 24),
        textAlign: TextAlign.right, // Align text to the right
        softWrap: true, // Allow text wrapping
        overflow: TextOverflow.visible, // Ensure text visibility
      ),
    ),
  );
}

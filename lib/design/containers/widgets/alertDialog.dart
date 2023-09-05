  import 'package:flutter/material.dart';

  class CustomAlertDialog extends StatelessWidget {
    final String title;
    final Widget content;

    const CustomAlertDialog({super.key,
      required this.title,
      required this.content,
    });

    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        backgroundColor: Colors.white,
      );
    }
  }

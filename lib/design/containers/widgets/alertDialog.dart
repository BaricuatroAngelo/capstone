import 'package:flutter/material.dart';

// class CustomAlertDialog extends StatelessWidget {
//   final String title;
//   final Widget content;
//
//   const CustomAlertDialog({
//     Key? key,
//     required this.title,
//     required this.content,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       content: content,
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Close'),
//         ),
//       ],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       elevation: 5,
//       backgroundColor: Colors.white,
//       contentPadding: const EdgeInsets.all(16),
//     );
//   }
// }

class HealthRecordPage extends StatelessWidget {
  final String title;
  final Widget content;

  const HealthRecordPage({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 2,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Center(
              child: Text(
            title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: content,
      )
    );
  }
}

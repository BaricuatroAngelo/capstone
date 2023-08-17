import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double screenHeight;
  final double screenWidth;

  GradientAppBar({
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff15aaff),
            Color(0xffadf7f2),
          ],
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0.0,
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 290) / 2),
          child: const Text('Patient Profile'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80); // Adjust as needed
}

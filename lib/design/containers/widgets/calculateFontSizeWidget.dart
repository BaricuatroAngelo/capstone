import 'package:flutter/material.dart';

class ResponsiveFontSize extends StatelessWidget {
  final double smallPhoneSize;
  final double mediumPhoneSize;
  final double largePhoneSize;

  const ResponsiveFontSize({
    Key? key,
    this.smallPhoneSize = 16,
    this.mediumPhoneSize = 18,
    this.largePhoneSize = 22,
  }) : super(key: key);

  double _calculateFontSize(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) {
      return smallPhoneSize;
    } else if (screenHeight < 1000) {
      return mediumPhoneSize;
    } else {
      return largePhoneSize;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sample Text',
      style: TextStyle(fontSize: _calculateFontSize(context)),
    );
  }
}

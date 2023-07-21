import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final centerTexts = Center(
  child: Text(
    'No medicines selected.',
    style: TextStyle(
      color: const Color(0xff000000).withOpacity(0.5),
    ),
  ),
);

const titleText = Text(
  'Selected Medicines:',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  ),
);
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

const patientInfoTexts = TextStyle(
  color: Color(0xff3a3a3a),
  fontSize: 20,
);

const patientAddress = Text(
  'Patient Name',
  style: TextStyle(
    fontSize: 15,
  ),
);

const patientAge = Text(
  'Patient Name',
  style: TextStyle(
    fontSize: 15,
  ),
);

const vacStatus = Text(
  'Patient Name',
  style: TextStyle(
    fontSize: 15,
  ),
);


const additionalInfo = Positioned(
  top: 400,
  left: 50,
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        patientAddress,
        patientAge,
        vacStatus,
      ],
    ),
  ),
);
const patientName = Positioned(
  top: 360,
  left: 110,
  child: Text(
    'Patient Name',
    style: TextStyle(
      fontSize: 30,
    ),
  ),
);
const notes = Positioned(
  top: 450,
  left: 20,
  child: Text(
    'Doctors Notes',
    style: TextStyle(
      fontSize: 30,
    ),
  ),
);

const page = Positioned(
  top: 54,
  left: 110,
  child: Text(
    'Patient Profile',
    style: TextStyle(
      fontSize: 30,
    ),
  ),
);

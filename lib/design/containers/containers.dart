import 'package:flutter/material.dart';

const viewPatientBox = BoxDecoration(
  borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(50),
      bottomLeft: Radius.circular(50)),
  color: Color(0xff66d0ed),
);

const upperCardBox = BoxDecoration(
  borderRadius: BorderRadius.only(
      topRight: Radius.circular(50),
      topLeft: Radius.circular(50)),
  color: Color(0xff66d0ed),
);

final patientCard = BoxDecoration(
  color: Colors.white,
  borderRadius:  const BorderRadius.all(Radius.circular(90)),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      blurRadius: 20,
      offset: const Offset(8, 20),
    ),
  ],
);

final personName = BoxDecoration(
  borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xff15aaff).withOpacity(0.4),
      const Color(0xffadf7f2),
    ],
  ),
);

final logoContainer = Container(
  height: 200,
  width: 300,
  decoration: const BoxDecoration(
    image: DecorationImage(
      image: ExactAssetImage('asset/ipimslogo.png'),
      fit: BoxFit.fill,
    ),
    shape: BoxShape.rectangle,
  ),
);

final buttonDesign = Container(
  height: 50,
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        color: Color(0xff99E9FF),
        blurRadius: 4,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: const Center(
    child: Text(
      'Login',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);

final clearButton = Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: Container(
    width: 150,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: const Color(0xff99e9ff).withOpacity(0.4),
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: const Center(
      child: Text(
        'Clear All',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    ),
  ),
);

final updateButton = Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: Container(
    width: 150,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: const Color(0xff99e9ff).withOpacity(0.4),
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: const Center(
      child: Text(
        'Update',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    ),
  ),
);

final medicinePage = Container(
  height: 90,
  width: 90,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        color: Color(0xff99E9FF),
        blurRadius: 3,
        offset: Offset(0, 5),
      ),
    ],
  ),
  child: const Icon(
    Icons.medical_information_outlined,
    size: 70,
  ),
);

final resultsPageBtn = Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: Container(
    width: 150,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: const Color(0xff99e9ff).withOpacity(0.4),
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: const Center(
      child: Text(
        'Results',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    ),
  ),
);

final medicinePageBtn = Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: Container(
    width: 170,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: const Color(0xff99e9ff).withOpacity(0.4),
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: const Center(
      child: Text(
        'Medicine Page',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    ),
  ),
);

final patientPhoto = Positioned(
    left: 200,
    top: 500,
    child: Center(
      child: Container(
        height: 170,
        width: 170,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xff99E9FF),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
      ),
    ));

final boxDecor = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
    BoxShadow(
      color: const Color(0xff99E9FF).withOpacity(0.4),
      blurRadius: 5,
      offset: const Offset(0, 4),
    ),
  ],
);

final selectBoxDecor = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(30),
  boxShadow: [
    BoxShadow(
      color: const Color(0xff99e9ff).withOpacity(0.4),
      offset: const Offset(0, 4),
    ),
  ],
);

final loginFieldDesign = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: Colors.white,
  boxShadow: const [
    BoxShadow(
      color: Color(0xff99E9FF),
      blurRadius: 4,
      offset: Offset(0, 4),
    ),
  ],
);

const space = SizedBox(
  height: 50,
);
const assignedRoom = Padding(
  padding: EdgeInsets.only(top: 20),
  child: Text(
    'Your Assigned Rooms:',
    style: TextStyle(
      fontSize: 18,
      color: Colors.black, // Use primary color
    ),
  ),
);

const homeContainer = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(90),
    topRight: Radius.circular(90),
  ),
);

const physExContainer = BoxDecoration(
  color: Colors.white,
);

const loadingContainer = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Color(0xff99E9FF),
      blurRadius: 4,
      offset: Offset(0, 4),
    ),
  ],
  shape: BoxShape.circle,
);

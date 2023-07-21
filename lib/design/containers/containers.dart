import 'package:flutter/material.dart';

// final TextEditingController _usernameController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();
//
// final userContainerDesign = Container(
//     height: 70,
//     width: double.infinity,
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.white,
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0xff99E9FF),
//             blurRadius: 4,
//             offset: Offset(0, 4),
//           ),
//         ]),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: TextFormField(
//         controller: _usernameController,
//         decoration: const InputDecoration(labelText: 'Username'),
//         validator: (value) {
//           if (value!.isEmpty) {
//             return 'Please enter your username';
//           }
//           return null;
//         },
//       ),
//     ));
//
// final passwordContainerDesign = Container(
//   height: 70,
//   width: double.infinity,
//   decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: Colors.white,
//       boxShadow: const [
//         BoxShadow(
//           color: Color(0xff99E9FF),
//           blurRadius: 4,
//           offset: Offset(0, 4),
//         ),
//       ]),
//   child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20),
//     child: TextFormField(
//       controller: _passwordController,
//       obscureText: true,
//       decoration: const InputDecoration(labelText: 'Password'),
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter your password';
//         }
//         return null;
//       },
//     ),
//   ),
// );

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

final resultsPage = Container(
  height: 90,
  width: 90,
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
  child: const Icon(
    Icons.medical_information,
    size: 70,
  ),
);

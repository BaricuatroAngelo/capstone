import 'package:capstone/pages/Models/resident.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'design/containers/containers.dart';
import 'navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    final url = Uri.parse('http://10.0.2.2:8000/api/resLogin');

    try {
      final response = await http.post(url, body: {
        'resident_userName': username,
        'resident_password': password,
      });

      final responseData = json.decode(response.body);

      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final token = responseData['token'];

        if (token.startsWith('R-')) {
          final residentJson = responseData['resident'];
          final resident = Resident.fromJson(residentJson);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NavBar(
                residentId: resident.residentId,
              ),
            ),
          );
        } else {
          setState(() {
            _errorMessage = 'Invalid token format';
          });
        }
      } else {
        final error = responseData['error'];
        setState(() {
          _errorMessage = error;
        });
      }
    } catch (e) {
      setState(() {
        print(e);
        _errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3F9FF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    logoContainer,
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff99E9FF),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _usernameController,
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff99E9FF),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        }
                      },
                      child: buttonDesign,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

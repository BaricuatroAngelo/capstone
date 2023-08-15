import 'package:capstone/pages/Models/resident.dart';
import 'package:capstone/pages/chiefResPages/chiefResLogin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../design/containers/containers.dart';
import 'navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late final String _token;
  String _errorMessage = '';

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = ''; // Clear any previous error message
    });

    final String username = _usernameController.text;
    final String password = _passwordController.text;

    final url = Uri.parse('http://172.30.0.28:8000/api/login');

    try {
      final response = await http.post(url, body: {
        'resident_userName': username,
        'resident_password': password,
      });

      final responseData = json.decode(response.body);

      print('${response.statusCode}');

      if (response.statusCode == 200) {
        final token = responseData['token'];

        print(response.body);

        if (token.isNotEmpty) {
          final residentJson = responseData['resident'];
          final resident = Resident.fromJson(residentJson);

          // Store the token in the _token variable
          _token = token;

          await Future.delayed(const Duration(seconds: 3));

          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 800),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: NavBar(
                    residentId: resident.residentId,
                    authToken: _token,
                  ),
                );
              },
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
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state after login attempt
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                        decoration: loginFieldDesign,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: _usernameController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 70,
                        width: double.infinity,
                        decoration: loginFieldDesign,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: _isLoading ? 60 : 50,
                        width: _isLoading ? 60 : double.infinity,
                        decoration: _isLoading ? loadingContainer : selectBoxDecor,
                        child: InkWell(
                          onTap: _isLoading
                              ? null // Disable button when loading
                              : () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          child: _isLoading
                              ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff99e9ff)),
                            ),
                          )
                              : const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Are you a chief resident?'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ChiefResLogin(),
                                ),
                              );
                            },
                            child: const Text('Click Here!'),
                          ),
                        ],
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
      ),
    );
  }
}

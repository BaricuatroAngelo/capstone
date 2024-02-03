import 'package:capstone/pages/Models/resident.dart';
import 'package:capstone/pages/chiefResPages/chiefResNavBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../design/containers/containers.dart';
import '../../design/containers/widgets/urlWidget.dart';
import '../loginpage.dart';

class ChiefResLogin extends StatefulWidget {
  const ChiefResLogin({super.key});

  @override
  ChiefResLoginState createState() => ChiefResLoginState();
}

class ChiefResLoginState extends State<ChiefResLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late final String _token;
  String _errorMessage = '';

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final String username = _usernameController.text;
    final String password = _passwordController.text;

    final url = Uri.parse('${Env.prefix}/api/login');

    try {
      final response = await http.post(url, body: {
        'resident_userName': username,
        'resident_password': password,
      });

      final responseData = json.decode(response.body);

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final token = responseData['token'];
        final role = responseData['resident']['role'];

        if (token.isNotEmpty && (role == 'chiefResident')) {
          final residentJson = responseData['resident'];
          final resident = Resident.fromJson(residentJson);

          _token = token;

          await Future.delayed(const Duration(seconds: 3));

          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 800),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: chiefNavBar(
                      residentId: resident.residentId, authToken: _token),
                );
              },
            ),
          ); // Navigate to chiefNavBar() page
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Account Not A Chief Resident!';
          });
        }
      } else {
        final error = responseData['error'];
        setState(() {
          _isLoading = false;
          _errorMessage = error;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred. Please try again later.';
      });
      print(e);
    }
  }

  //
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
                      Container(
                        height: _isLoading ? 60 : 50,
                        width: double.infinity,
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
                          child: Center(
                            child: _isLoading
                                ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff99e9ff)),
                            )
                                : const Text(
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
                          const Text('Go back to resident login?'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
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
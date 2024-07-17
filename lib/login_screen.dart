// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:loginvalidate_exam/home_screen.dart';
import 'package:loginvalidate_exam/register_screen.dart';

class LoginValidate extends StatefulWidget {
  final String username;
  final String password;
  LoginValidate({required this.username, required this.password});

  @override
  State<LoginValidate> createState() => _LoginValidateState();
}

class _LoginValidateState extends State<LoginValidate> {
  TextEditingController _userController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  final usernameformKey = GlobalKey<FormState>();

  final passwordformKey = GlobalKey<FormState>();

  bool _isChecked = false;

  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Sign in to your Account",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: usernameformKey,
                        child: TextFormField(
                          onTapOutside: (event) => {
                            FocusManager.instance.primaryFocus?.unfocus(),
                          },
                          controller: _userController,
                          decoration: InputDecoration(
                            hintText: "Your Email Address",
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: Color(0xffbbbbbb)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.black87,
                                width: 1,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: passwordformKey,
                        child: TextFormField(
                          onTapOutside: (event) => {
                            FocusManager.instance.primaryFocus?.unfocus(),
                          },
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Your Password",
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: Color(0xffbbbbbb)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.black87,
                                width: 1,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value != widget.password) {
                              return 'Incorrect Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    setState(() {
                                      _isChecked = value;
                                    });
                                  }
                                },
                              ),
                              Text(
                                "Remember me",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Forgot password",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          checkLogin(context);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xff1a75d0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registerscreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Color(0xff1a75d0)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext context) {
    if (usernameformKey.currentState != null &&
        usernameformKey.currentState!.validate() &&
        passwordformKey.currentState != null &&
        passwordformKey.currentState!.validate()) {
      if (_userController.text == widget.username &&
          _passwordController.text == widget.password) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Incorrect username or password',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../controllers/auth_controller.dart';
class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  String _name = "";
  bool _isHidden = true;

  late AuthController _authController;
  void toggleView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
// TODO: implement dispose
    super.dispose();
    _authController.onDelete();
  }
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: error.isNotEmpty?Text(error):const Text(''),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            height: 40,
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white38,
                border: InputBorder.none,
                hintText: "Name",
                suffixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                 setState(() {
                   error = 'Please enter your name';
                 });
                }
                return null;
              },
              onChanged: (value) => setState(() {
                error='';
              }),
              onSaved: (value) {
                _name = value!;
              },
              style: const TextStyle(height: 1.0),
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            height: 40,
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white38,
                border: InputBorder.none,
                hintText: "Email",
                suffixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                 setState(() {
                   error = 'Please enter your email address';
                 });
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                    .hasMatch(value!)) {
                 setState(() {
                   error = 'Please enter a valid email address';
                 });
                }
                return null;
              },
              onChanged: (value) => setState(() {
                error = '';
              }),
              onSaved: (value) {
                _email = value!;
              },
              style: const TextStyle(height: 1.0),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            height: 40,
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white38,
                border: InputBorder.none,
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    _isHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isHidden = !_isHidden;
                    });
                  },
                ),
              ),
              obscureText: _isHidden,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    error = 'Please enter your password';
                  });
                }
                if (value!.length < 6) {
                 setState(() {
                   error = 'Password must be at least 6 characters long';
                 });
                }
                return null;
              },
              onSaved: (value) {
                setState(() {
                  _password = value!;
                });
              },
              onChanged: (value) => setState(() {
                error = '';
              }),
              style: const TextStyle(height: 1.0),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            height: 40,
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white38,
                border: InputBorder.none,
                hintText: "Confirm Password",
              ),
              obscureText: _isHidden,
              validator: (value) {
                if (value == null || value.isEmpty) {
                 setState(() {
                   error = 'Please enter your password';
                 });
                }
                if (value != _password) {
                  setState(() {
                    error = 'Passwords do not match';
                  });
                }
                return null;
              },
              onChanged: (value) {
               error = '';
              },
              onSaved: (newValue) {
                setState(() {
                  _confirmPassword = newValue!;
                });
              },
              style: const TextStyle(height: 1.0),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _authController.signUp(_email, _password, _name);
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(widgetColor)),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}

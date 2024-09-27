import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import '../controllers/auth_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late AuthController _authController;
  String _email = "";
  String _password = "";
  bool _isHidden = true;

  void toggleView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    super.dispose();
    _authController.onDelete();
  }
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: error.isNotEmpty?Text(error):const Text(''),
          ),
          const SizedBox(height: 20),
          // Email Field with validation message
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            height: 40,
            child: TextFormField(
              cursorHeight: 2,
              expands: false,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white38,
                border: InputBorder.none,
                hintText: "Email",
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
                error='';
              }),
              onSaved: (value) {
                _email = value!;
              },
              style: const TextStyle(height: 1.0),
            ),
          ),
          // Password Field with validation message
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            height: 40,
            child: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white38,
                border: InputBorder.none,
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    _isHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: toggleView,
                ),
              ),
              obscureText: _isHidden,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                   error = 'Pleas Enter a value';
                  });
                }
                if (value!.length < 6) {
                 setState(() {
                   error = 'Password must be at least 6 characters long';
                 });
                }
                return null;
              },
              onChanged: (value) => setState(() {
                error='';
              }),
              onSaved: (value) {
                _password = value!;
              },
              style: const TextStyle(height: 1.0),
            ),
          ),
          // Login Button
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                    if(error.isEmpty){
                      _formKey.currentState!.save();
                      _authController.signIn(_email, _password);
                    }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(widgetColor),
              ),
              child: const Text(
                "Log In",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

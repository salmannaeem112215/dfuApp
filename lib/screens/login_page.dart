import 'package:flutter/material.dart';
import 'package:flutter_ui/headers.dart';
import 'package:flutter_ui/routes/app_routes.dart';
import 'package:flutter_ui/utility/my_firebase.dart';
import 'package:flutter_ui/utility/snackbar.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/route_manager.dart';
import 'questionnaire_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Back', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF33657D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Get.previousRoute == AppRoutes.rOnboarding) {
              Get.back();
            } else {
              Get.offAndToNamed(AppRoutes.rOnboarding);
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', width: 120),
              SizedBox(height: 20),
              _buildEmailField(),
              SizedBox(height: 9),
              _buildPasswordField(),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF33657D)),
                onPressed: _validateAndLogin,
                child: Text('Login',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateAndLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Login successful!')),
      // );
      _onLogin();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => QuestionnairePage()),
      // );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please ensure all fields are filled out correctly')),
      );
    }
  }

  _onLogin() async {
    try {
      final res = await Get.find<AppController>().login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (e) {
      final message = e is String ? e : 'Unable To Login';
      MySnackbar.error(message);
    }
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon:
            Icon(Icons.email, color: const Color.fromARGB(255, 73, 72, 72)),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      cursorColor: Colors.black,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon:
            Icon(Icons.lock, color: const Color.fromARGB(255, 73, 72, 72)),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color.fromARGB(255, 73, 72, 72),
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      cursorColor: Colors.black,
      obscureText: !_isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return 'Password must contain at least one uppercase letter';
        } else if (!RegExp(r'[a-z]').hasMatch(value)) {
          return 'Password must contain at least one lowercase letter';
        }
        return null;
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportshopping/screens/auth/sign_in_screen.dart';

import '../../blocs/auth_service.dart';
import '../../components/my_text_field.dart';
import '../../components/wave_clipper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthService();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: Colors.lightBlue[200],
                  height: 150, // Altura fixa para o cabeçalho
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: Colors.lightBlue.shade200,
                          thickness: 2.0,
                          endIndent: 250.0,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Username',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        MyTextField(
                          controller: nameController,
                          hintText: 'Hezio Cumba',
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(CupertinoIcons.person),
                          validator: validateName,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Email',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        MyTextField(
                          controller: emailController,
                          hintText: 'demo@gmail.com',
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(CupertinoIcons.mail),
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Phone No',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        MyTextField(
                          controller: phoneController,
                          hintText: '+258 84*******',
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          prefixIcon: const Icon(CupertinoIcons.phone),
                          validator: validatePhone,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Password',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        MyTextField(
                          controller: passwordController,
                          hintText: '********',
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: const Icon(CupertinoIcons.padlock),
                          validator: validatePassword,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Confirm Password',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        MyTextField(
                          controller: confirmPasswordController,
                          hintText: '********',
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: const Icon(CupertinoIcons.padlock),
                          validator: (value) => validateConfirmPassword(value, passwordController.text),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _signUp();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 130,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Sign up'),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account? '),
                            GestureDetector(
                              onTap: () {
                                goToLogin(context);
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )

              ),
            ],
          ),
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()));

  // _signUp() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       final user = await _auth.createUser(
  //         emailController.text,
  //         confirmPasswordController.text,
  //         nameController.text,
  //         int.tryParse(phoneController.text) ?? 0,
  //       );
  //       if (user != null) {
  //         print("User created successfully");
  //         goToLogin(context);
  //       }
  //     } catch (e) {
  //       print("Error creating user: $e");
  //     }
  //     print('Form is valid');
  //   } else {
  //     print('Form is invalid');
  //   }
  //
  // }
  _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await _auth.createUser(
          emailController.text.trim(),
          confirmPasswordController.text.trim(),
          nameController.text.trim(),
          phoneController.text.trim(),
        );
        if (user != null) {
          print("User created successfully");
          goToLogin(context);
        }
      } catch (e) {
        print("Error creating user: $e");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Sign-Up Error"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } else {
      print('Form is invalid');
    }
  }


  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

}

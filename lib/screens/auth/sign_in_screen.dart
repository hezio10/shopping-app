import 'dart:math';


// import 'package:englishlearningapp/screens/auth/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportshopping/my_app_view.dart';
import 'package:sportshopping/screens/auth/sign_up_screen.dart';
import 'package:sportshopping/screens/home_page.dart';

import '../../blocs/auth_service.dart';
import '../../components/my_text_field.dart';
import '../../components/wave_clipper.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthService();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool isChecked = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Colors.lightBlue[200],
                height: 300, // Altura fixa para o cabeçalho
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
                      'Sign in',
                      style: TextStyle(
                          fontSize: 38, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.lightBlue.shade200,
                      thickness: 2.0,
                      endIndent: 250.0,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    MyTextField(
                      controller: emailController,
                      hintText: 'demo@gmail.com',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(CupertinoIcons.mail),
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    MyTextField(
                      controller: passwordController,
                      hintText: '********',
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(CupertinoIcons.padlock),
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 5),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Text('Remember me'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // Lógica de esqueci a senha
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _signIn();
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

                        child: const Text('Login'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            goToSignUp(context);
                          },
                          child: const Text(
                            'Sign up',
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
              ),
            ),
          ],
        ),
      ),
    );
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
      return 'Please enter your password';
    }
    return null;
  }

  goToSignUp(BuildContext context) =>
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );

  goToHome(BuildContext context) =>
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  MyAppView()),
      );


  Future<void> _signIn() async {
    // goToHome(context);
    if (_formKey.currentState!.validate()) {
      try {
        final user = await _auth.singInUserWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
        if (user != null) {
          goToHome(context);
        }else {
          log(0);
          setState(() {
            errorMessage = 'Invalid email or password';
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = 'Invalid email or password';
        });
      }
    }
  }
}

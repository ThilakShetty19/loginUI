import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modern_login_ui/components/my_button.dart';
import 'package:modern_login_ui/components/my_text_field.dart';
import 'package:modern_login_ui/components/square_tile.dart';
import 'package:modern_login_ui/services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailControler = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void singnUserUp() async {
    if (_formkey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        // check password is confirmed
        if (confirmPasswordController.text == confirmPasswordController.text) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailControler.text,
            password: passwordController.text,
          );
        } else {
          // error message, password wrong
          showErorrMessage("password don't match");
        }
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        //show error message
        showErorrMessage(e.code);
      }
    }
  }

  void showErorrMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.purple[100],
            title: Text(message),
          );
        });
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'email is required';
    }
    return null;
  }

  String? paswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'password is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
       
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    Icons.lock,
                    size: 60,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Register now",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  MyTextField(
                    validator: emailValidator,
                    controller: emailControler,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    validator: paswordValidator,
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    validator: paswordValidator,
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),
                  MyButton(
                    text: 'Sign up',
                    onTap: () {
                      singnUserUp();
                    },
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Or continue with'),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        onTap: () async =>
                            await AuthServices().signInWithGoogle(),
                        imagePath: 'lib/images/google.png',
                      ),
                      const SizedBox(width: 25),
                      SquareTile(
                        onTap: () {},
                        imagePath: 'lib/images/apple.png',
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

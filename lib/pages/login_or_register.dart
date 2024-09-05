import 'package:flutter/material.dart';
import 'package:modern_login_ui/pages/login_page.dart';
import 'package:modern_login_ui/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLogiPage = true;

  void togglePage() {
    setState(() {
      showLogiPage = !showLogiPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogiPage) {
      return LoginPage(
        onTap: togglePage,
      );
    } else {
      return RegisterPage(
        onTap: togglePage,
      );
    }
  }
}

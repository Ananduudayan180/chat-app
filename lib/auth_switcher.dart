import 'package:chat_app/features/auth/presentation/pages/login_page.dart';
import 'package:chat_app/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthSwitcher extends StatefulWidget {
  const AuthSwitcher({super.key});

  @override
  State<AuthSwitcher> createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<AuthSwitcher> {
  bool isLoginPage = true;
  @override
  Widget build(BuildContext context) {
    //switch login and register page
    void toggleAuth() {
      setState(() {
        isLoginPage = !isLoginPage;
      });
    }

    return isLoginPage
        ? LoginPage(toggle: toggleAuth)
        : RegisterPage(toggle: toggleAuth);
  }
}

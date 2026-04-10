import 'package:chat_app/core/theme/dark_mode.dart';
import 'package:chat_app/features/auth/presentation/pages/auth_switcher.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode,
      home: AuthSwitcher(),
    );
  }
}

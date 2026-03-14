import 'package:chat_app/core/config/firebase_options.dart';
import 'package:chat_app/core/theme/dark_mode.dart';
import 'package:chat_app/features/auth/presentation/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode,
      home: RegisterPage(),
    );
  }
}

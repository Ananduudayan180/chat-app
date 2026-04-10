import 'package:chat_app/core/theme/dark_mode.dart';
import 'package:chat_app/core/theme/light_mode.dart';
import 'package:chat_app/features/auth/presentation/pages/auth_switcher.dart';
import 'package:chat_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state.isDark ? darkMode : lightMode,
          home: AuthSwitcher(),
        );
      },
    );
  }
}

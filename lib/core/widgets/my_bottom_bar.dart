import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  final void Function(int index)? onTap;
  const MyBottomBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return CurvedNavigationBar(
      height: 60,
      animationDuration: Duration(milliseconds: 300),
      animationCurve: Curves.fastOutSlowIn,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: theme.primary,
      color: theme.surface,
      items: [
        //chat
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(Icons.chat_rounded, size: 26),
        ),
        //settings
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(Icons.settings_rounded, size: 26),
        ),
        //profile
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(Icons.group_rounded, size: 26),
        ),
      ],
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  const MyButton({super.key, required this.buttonName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Material(
        color: theme.primary,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5),
          child: SizedBox(
            width: 250,
            height: 44,
            child: Center(
              child: Text(
                buttonName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

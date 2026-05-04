import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final bool enable;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    required this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        minLines: 1,
        maxLines: maxLines ?? 1,
        enabled: enable,
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.colorScheme.surface,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefixIconConstraints: BoxConstraints(maxHeight: 32, minWidth: 32),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: theme.inputDecorationTheme.hintStyle!.color!,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          ),
          hoverColor: Colors.black12,
        ),
        validator: validator,
      ),
    );
  }
}

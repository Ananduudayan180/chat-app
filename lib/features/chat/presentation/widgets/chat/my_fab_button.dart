import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyFabButton extends StatelessWidget {
  final VoidCallback onPressed;
  const MyFabButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FloatingActionButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        //decaration
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.orange],
            begin: AlignmentGeometry.bottomLeft,
            end: AlignmentGeometry.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          //icon
          child: FaIcon(
            FontAwesomeIcons.solidMessage,
            color: theme.iconTheme.color,
          ),
        ),
      ),
    );
  }
}

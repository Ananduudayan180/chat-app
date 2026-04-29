import 'package:flutter/material.dart';

class Dialogs {
  static void showDialogBox({
    required String title,
    required String actionText,
    required VoidCallback onTap,
    required BuildContext context,
    required Widget content,
    Color? actionColor,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(title, style: TextStyle(fontSize: 22)),
          content: content,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[500])),
            ),
            TextButton(
              onPressed: onTap,
              child: Text(
                actionText,
                style: TextStyle(color: actionColor ?? Colors.grey[500]),
              ),
            ),
          ],
        );
      },
    );
  }
}

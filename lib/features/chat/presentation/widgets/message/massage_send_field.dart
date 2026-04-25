import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class MassageSendField extends StatelessWidget {
  final bool isBlocked;
  final bool isDeleted;
  final String hintText;
  final VoidCallback? onTap;
  final TextEditingController messageController;
  const MassageSendField({
    super.key,
    required this.isBlocked,
    required this.isDeleted,
    required this.messageController,
    required this.hintText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              enable: !isDeleted && !isBlocked,
              controller: messageController,
              hintText: hintText,
              validator: null,
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: !isDeleted && !isBlocked ? onTap : null,
            child: CircleAvatar(
              backgroundColor: theme.surface,
              radius: 22,
              child: Icon(Icons.send, color: theme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

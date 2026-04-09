import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/domain/entity/message_model.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  final List<MessageModel> messages;
  const MessageList({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final currentUserUid = AuthService().currentUserUid;
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: message.senderId != currentUserUid
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ), //msg container
                    child: Container(
                      decoration: BoxDecoration(
                        color: message.senderId != currentUserUid
                            ? theme.surface
                            : theme.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topRight: message.senderId != currentUserUid
                              ? Radius.circular(15)
                              : Radius.circular(0),
                          topLeft: message.senderId != currentUserUid
                              ? Radius.circular(0)
                              : Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          message.text,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

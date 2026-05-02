import 'package:chat_app/features/chat/domain/entity/message_model.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageList extends StatelessWidget {
  final List<MessageModel> messages;
  final String chatId;
  final String currentUserUid;
  const MessageList({
    super.key,
    required this.messages,
    required this.chatId,
    required this.currentUserUid,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    if (messages.last.senderId != currentUserUid) {
      context.read<ChatBloc>().add(ResetUnreadCountEvent(chatId: chatId));
    }
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

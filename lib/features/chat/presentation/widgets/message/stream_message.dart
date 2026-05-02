import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/message/message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StreamMessage extends StatelessWidget {
  final String chatId;
  const StreamMessage({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final currentUserUid = AuthService().currentUserUid;
    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is MessageError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        if (state is MessageLoaded) {
          if (state.messages.isEmpty) {
            //empty svg
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/messaging_amico.svg',
                    width: 250,
                  ),
                  SizedBox(height: 10),
                  Text('Say hello 👋', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          } else {
            return MessageList(
              messages: state.messages,
              chatId: chatId,
              currentUserUid: currentUserUid,
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

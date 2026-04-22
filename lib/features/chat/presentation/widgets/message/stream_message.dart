import 'package:chat_app/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/message/message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreamMessage extends StatelessWidget {
  const StreamMessage({super.key});

  @override
  Widget build(BuildContext context) {
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
            //lottie + start chat
            return Center(child: Text('Empty'));
          } else {
            return MessageList(messages: state.messages);
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

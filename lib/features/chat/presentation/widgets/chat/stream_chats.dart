import 'package:chat_app/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreamChats extends StatelessWidget {
  const StreamChats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        if (state is ChatLoaded) {
          if (state.chats.isEmpty) {
            //lottie
            return Center(child: Text('Lottie'));
          } else {
            return ChatList(chats: state.chats);
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat/stream_chats.dart';
import 'package:chat_app/features/users/presentation/bloc/block/block_bloc.dart';
import 'package:chat_app/features/users/presentation/pages/users_page.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat/my_fab_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(StreamChatsEvent());
    context.read<BlockBloc>().add(
      GetBlockedUserIds(currentUserUid: AuthService().currentUserUid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            //title & text field
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //title
                const Text(
                  'Chatify',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                //my text field
                MyTextField(
                  controller: searchController,
                  hintText: 'Search',
                  validator: null,
                ),
              ],
            ),
          ),
          //chat list
          Flexible(
            child: Stack(
              children: [
                StreamChats(),
                //FAB
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: MyFabButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UsersPage()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

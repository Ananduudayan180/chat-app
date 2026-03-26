import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_list.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
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
          ChatList(),
        ],
      ),
    );
  }
}

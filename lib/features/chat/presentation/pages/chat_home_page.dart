import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:chat_app/features/users/presentation/pages/users_list_page.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_list.dart';
import 'package:chat_app/features/chat/presentation/widgets/my_fab_button.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatelessWidget {
  ChatHomePage({super.key});

  final searchController = TextEditingController();

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
          Expanded(
            child: Stack(
              children: [
                //chat list
                ChatList(),
                //FAB
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: MyFabButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UsersListPage()),
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

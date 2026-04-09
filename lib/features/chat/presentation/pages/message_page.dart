import 'package:chat_app/core/widgets/common_profile_avatar.dart';
import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/stream_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagePage extends StatefulWidget {
  final String otherUserUid;
  final String name;
  final String profileImageUrl;
  const MessagePage({
    super.key,
    required this.otherUserUid,
    required this.name,
    required this.profileImageUrl,
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MessageBloc>().add(
      StreamMessageEvent(chatId: genarateChatId()),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  final currentUserUid = AuthService().currentUserUid;
  //genarate chatId
  String genarateChatId() {
    final ids = [currentUserUid, widget.otherUserUid];
    ids.sort();
    final chatId = ids.join('_');
    return chatId;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      //chat send textfiled
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: MyTextField(
                controller: _messageController,
                hintText: 'Send message',
                validator: null,
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                //send msg
              },
              child: CircleAvatar(
                backgroundColor: theme.surface,
                radius: 22,
                child: Icon(Icons.send, color: theme.primary),
              ),
            ),
          ],
        ),
      ),
      //AppBar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: Row(
          children: [
            CommonProfileAvatar(
              profileImageUrl: widget.profileImageUrl,
              radius: 19,
              iconSize: 26,
            ),
            SizedBox(width: 7),
            Text(widget.name, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),

      body: StreamMessage(),
    );
  }
}

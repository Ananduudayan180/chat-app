import 'package:chat_app/core/widgets/common_profile_avatar.dart';
import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/domain/entity/message_model.dart';
import 'package:chat_app/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/message/stream_message.dart';
import 'package:chat_app/features/users/presentation/bloc/block/block_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessagePage extends StatefulWidget {
  final String otherUserUid;
  final String name;
  final String profileImageUrl;
  final bool isDeleted;
  const MessagePage({
    super.key,
    required this.otherUserUid,
    required this.name,
    required this.profileImageUrl,
    required this.isDeleted,
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

  //send msg
  void saveMessage() {
    if (_messageController.text.isEmpty) return;
    final message = MessageModel(
      senderId: currentUserUid,
      text: _messageController.text,
      createdAt: Timestamp.now(),
    );

    context.read<MessageBloc>().add(
      SaveMessageEvent(
        message: message,
        chatId: genarateChatId(),
        participants: [currentUserUid, widget.otherUserUid],
      ),
    );
    _messageController.clear();
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
                enable: !widget.isDeleted,
                controller: _messageController,
                hintText: !widget.isDeleted
                    ? 'Send message'
                    : 'You can’t message this user',
                validator: null,
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: saveMessage,
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
        actions: [
          MenuAnchor(
            style: MenuStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).scaffoldBackgroundColor,
              ),
              elevation: const WidgetStatePropertyAll(8),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            builder: (context, controller, child) {
              return IconButton(
                onPressed: () =>
                    controller.isOpen ? controller.close() : controller.open(),
                icon: Icon(Icons.more_vert_outlined),
              );
            },
            menuChildren: [
              MenuItemButton(
                leadingIcon: FaIcon(
                  FontAwesomeIcons.ban,
                  color: Colors.red,
                  size: 18,
                ),
                child: Text('Block', style: TextStyle(color: Colors.red)),
                onPressed: () => context.read<BlockBloc>().add(
                  BlockUser(
                    currentUserUid: currentUserUid,
                    otherUserUid: widget.otherUserUid,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      body: StreamMessage(),
    );
  }
}

import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/domain/entity/message_model.dart';
import 'package:chat_app/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/message/massage_send_field.dart';
import 'package:chat_app/features/chat/presentation/widgets/message/message_appbar.dart';
import 'package:chat_app/features/chat/presentation/widgets/message/stream_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagePage extends StatefulWidget {
  final String otherUserUid;
  final String name;
  final String profileImageUrl;
  final bool isDeleted;
  final bool isBlocked;
  const MessagePage({
    super.key,
    required this.otherUserUid,
    required this.name,
    required this.profileImageUrl,
    required this.isDeleted,
    required this.isBlocked,
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
    return Scaffold(
      //chat send textfiled
      bottomNavigationBar: MassageSendField(
        blockState: widget.isBlocked,
        isDeleted: widget.isDeleted,
        messageController: _messageController,
        onTap: widget.isBlocked || widget.isDeleted ? null : saveMessage,
      ),
      //AppBar
      appBar: MessageAppbar(
        otherUserUid: widget.otherUserUid,
        currentUserUid: currentUserUid,
        isDeleted: widget.isDeleted,
        blockState: widget.isBlocked,
        name: widget.name,
        profileImageUrl: widget.profileImageUrl,
      ),
      body: StreamMessage(),
    );
  }
}

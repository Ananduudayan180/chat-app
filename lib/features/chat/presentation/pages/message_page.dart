import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/domain/entity/message_model.dart';
import 'package:chat_app/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/message/massage_send_field.dart';
import 'package:chat_app/features/chat/presentation/widgets/message/message_appbar.dart';
import 'package:chat_app/features/chat/presentation/widgets/message/stream_message.dart';
import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:chat_app/features/users/presentation/bloc/block/block_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagePage extends StatefulWidget {
  final AppUserModel user;
  final bool isDeleted;
  final bool blockedByCurrentUser;
  final bool blockedByOtherUser;
  const MessagePage({
    super.key,
    required this.user,
    required this.isDeleted,
    required this.blockedByCurrentUser,
    required this.blockedByOtherUser,
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
    final ids = [currentUserUid, widget.user.uid];
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
        participants: [currentUserUid, widget.user.uid],
      ),
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    bool blockedByCurrentUser = widget.blockedByCurrentUser;
    return BlocConsumer<BlockBloc, BlockState>(
      buildWhen: (previous, current) => current is BlockSuccess,
      listener: (context, state) {
        if (state is BlockSuccess) {
          blockedByCurrentUser = state.isBlocked;
        }
      },
      builder: (context, state) {
        return Scaffold(
          //chat send textfiled
          bottomNavigationBar: MassageSendField(
            isBlocked: blockedByCurrentUser || widget.blockedByOtherUser,
            isDeleted: widget.isDeleted,
            messageController: _messageController,
            onTap: saveMessage,
            hintText: blockedByCurrentUser
                ? 'You blocked this user'
                : widget.blockedByOtherUser
                ? 'You cannot message this user'
                : widget.isDeleted
                ? 'This account is deleted'
                : 'Send message',
          ),
          //AppBar
          appBar: MessageAppbar(
            user: widget.user,
            currentUserUid: currentUserUid,
            isDeleted: widget.isDeleted,
            isBlocked: blockedByCurrentUser || widget.blockedByOtherUser,
            blockedByCurrentUser: blockedByCurrentUser,
          ),
          body: const StreamMessage(),
        );
      },
    );
  }
}

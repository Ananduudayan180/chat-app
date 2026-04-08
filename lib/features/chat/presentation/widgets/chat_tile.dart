import 'package:chat_app/core/widgets/common_profile_avatar.dart';
import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:chat_app/features/chat/presentation/pages/message_page.dart';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatTile extends StatelessWidget {
  final ProfileModel profile;
  final ChatModel chat;
  const ChatTile({super.key, required this.profile, required this.chat});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //formate time
    String formateTimestamp(Timestamp timestamp) {
      final time = DateFormat('h:mm a').format(timestamp.toDate());
      return time;
    }

    return ListTile(
      //navigate to msg page
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => MessagePage())),
      leading: CommonProfileAvatar(profileImageUrl: profile.profileImageUrl),
      //title
      title: Text(profile.name),
      //last msg
      subtitle: Text(chat.lastMsg, style: TextStyle(color: theme.dividerColor)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formateTimestamp(chat.lastMsgTime),
            style: TextStyle(color: theme.colorScheme.primary, fontSize: 12),
          ),
          SizedBox(height: 5),
          //notification container
          Container(
            width: 18,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.orangeAccent],
                begin: AlignmentGeometry.bottomLeft,
                end: AlignmentGeometry.bottomRight,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                chat.unreadCount.toString(),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

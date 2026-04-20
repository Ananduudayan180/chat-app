import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat/chat_tile.dart';
import 'package:chat_app/features/profile/data/service/profile_firestore_service.dart';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  final List<ChatModel> chats;
  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    final profileservice = ProfileFirestoreService();
    return ListView.separated(
      itemBuilder: (context, index) {
        final chat = chats[index];
        final otherUserUid = chat.otherUserUid;
        //list tile
        return FutureBuilder(
          future: profileservice.fetchUserProfile(otherUserUid!),
          builder:
              (BuildContext context, AsyncSnapshot<ProfileModel?> snapshot) {
                final profile = snapshot.data;
                return profile != null
                    ? ChatTile(profile: profile, chat: chat)
                    : ChatTile(
                        chat: chat,
                        isDeleted: true,
                        profile: ProfileModel(
                          uid: otherUserUid,
                          name: 'Deleted User',
                          email: '',
                          profileImageUrl: '',
                        ),
                      );
              },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(indent: 78, thickness: 0.1);
      },
      itemCount: chats.length,
    );
  }
}

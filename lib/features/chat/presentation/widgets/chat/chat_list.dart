import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat/chat_tile.dart';
import 'package:chat_app/features/profile/data/service/profile_firestore_service.dart';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:chat_app/features/users/presentation/bloc/block/block_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatList extends StatelessWidget {
  final List<ChatModel> chats;
  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    final profileservice = ProfileFirestoreService();
    return BlocConsumer<BlockBloc, BlockState>(
      listener: (context, state) {
        if (state is BlockError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
        if (state is BlockSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.successMsg)));
          // get blocked users ids
          context.read<BlockBloc>().add(
            GetBlockedUserIds(currentUserUid: AuthService().currentUserUid),
          );
        }
      },
      builder: (context, state) {
        if (state is BlockedUserIdsLoaded) {
          final blockedUsersIds = state.blockedUserIds;
          return ListView.separated(
            itemBuilder: (context, index) {
              final chat = chats[index];
              final otherUserUid = chat.otherUserUid;
              //list tile
              return FutureBuilder(
                future: profileservice.fetchUserProfile(otherUserUid!),
                builder:
                    (
                      BuildContext context,
                      AsyncSnapshot<ProfileModel?> snapshot,
                    ) {
                      if (snapshot.hasData && snapshot.data != null) {
                        final profile = snapshot.data!;
                        final isBlocked = blockedUsersIds.contains(profile.uid);
                        return !isBlocked
                            //blocked user and unblocked users
                            ? ChatTile(profile: profile, chat: chat)
                            : ChatTile(
                                chat: chat,
                                isBlocked: true,
                                profile: ProfileModel(
                                  uid: otherUserUid,
                                  name: profile.name,
                                  email: '',
                                  profileImageUrl: profile.profileImageUrl,
                                ),
                              );
                      } else if (!snapshot.hasData && snapshot.data == null) {
                        //deleted account
                        return ChatTile(
                          chat: chat,
                          isDeleted: true,
                          profile: ProfileModel(
                            uid: otherUserUid,
                            name: 'Deleted User',
                            email: '',
                            profileImageUrl: '',
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
              );
            },
            separatorBuilder: (context, index) {
              return Divider(indent: 78, thickness: 0.1);
            },
            itemCount: chats.length,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

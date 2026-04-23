import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat/chat_tile.dart';
import 'package:chat_app/features/users/data/service/users_service.dart';
import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:chat_app/features/users/presentation/bloc/block/block_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatList extends StatelessWidget {
  final List<ChatModel> chats;
  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    final usersService = UsersService();
    final currentUserUid = AuthService().currentUserUid;
    //this bloc for get current user blocked ids
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
                future: usersService.fetchUser(otherUserUid!),
                builder:
                    (
                      BuildContext context,
                      AsyncSnapshot<AppUserModel?> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox();
                      }
                      if (snapshot.hasError) {
                        return SizedBox();
                      }
                      if (snapshot.hasData && snapshot.data != null) {
                        final user = snapshot.data!;
                        final blockedByCurrentUser = blockedUsersIds.contains(
                          user.uid,
                        );
                        final blockedByOtherUser = user.blockedUserIds.contains(
                          currentUserUid,
                        );
                        final isBlocked =
                            blockedByCurrentUser || blockedByOtherUser;

                        return !isBlocked
                            //blocked user and unblocked users
                            ? ChatTile(user: user, chat: chat)
                            : ChatTile(
                                chat: chat,
                                isBlocked: true,
                                user: AppUserModel(
                                  uid: otherUserUid,
                                  name: user.name,
                                  profileImageUrl: user.profileImageUrl,
                                  blockedUserIds: user.blockedUserIds,
                                ),
                              );
                      } else {
                        //deleted account
                        return ChatTile(
                          chat: chat,
                          isDeleted: true,
                          user: AppUserModel(
                            uid: otherUserUid,
                            name: 'Deleted User',
                            profileImageUrl: '',
                            blockedUserIds: [],
                          ),
                        );
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

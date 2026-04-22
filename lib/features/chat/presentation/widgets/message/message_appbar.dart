import 'package:chat_app/core/widgets/common_profile_avatar.dart';
import 'package:chat_app/features/users/presentation/bloc/block/block_bloc.dart';
import 'package:chat_app/features/users/presentation/widgets/block_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String otherUserUid;
  final String currentUserUid;
  final String name;
  final String profileImageUrl;
  final bool isDeleted;
  final bool blockState;
  const MessageAppbar({
    super.key,
    required this.otherUserUid,
    required this.currentUserUid,
    required this.isDeleted,
    required this.blockState,
    required this.name,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    bool isBlocked = blockState;
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios, size: 20),
      ),
      title: BlocBuilder<BlockBloc, BlockState>(
        buildWhen: (previous, current) => current is BlockSuccess,
        builder: (context, state) {
          if (state is BlockSuccess) {
            isBlocked = state.isBlocked;
          }
          return Row(
            children: [
              CommonProfileAvatar(
                profileImageUrl: isBlocked ? '' : profileImageUrl,
                radius: 19,
                iconSize: 26,
              ),
              SizedBox(width: 7),
              Text(
                isBlocked ? 'Blocked user' : name,
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
        },
      ),
      //block unblock popup
      actions: [
        !isDeleted
            ? BlocBuilder<BlockBloc, BlockState>(
                buildWhen: (previous, current) => current is BlockSuccess,
                builder: (context, state) {
                  if (state is BlockSuccess) {
                    isBlocked = state.isBlocked;
                  }
                  return BlockPopup(
                    otherUserUid: otherUserUid,
                    currentUserUid: currentUserUid,
                    isBlocked: isBlocked,
                    bgColor: Theme.of(context).scaffoldBackgroundColor,
                  );
                },
              )
            : SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

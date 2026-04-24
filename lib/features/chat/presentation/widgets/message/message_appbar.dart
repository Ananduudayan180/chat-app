import 'package:chat_app/core/widgets/common_profile_avatar.dart';
import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:chat_app/features/users/presentation/widgets/block_popup.dart';
import 'package:flutter/material.dart';

class MessageAppbar extends StatelessWidget implements PreferredSizeWidget {
  final AppUserModel user;
  final String currentUserUid;
  final bool blockedByCurrentUser;
  final bool isDeleted;
  final bool isBlocked;
  const MessageAppbar({
    super.key,
    required this.user,
    required this.currentUserUid,
    required this.isDeleted,
    required this.isBlocked,
    required this.blockedByCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios, size: 20),
      ),
      title: Row(
        children: [
          CommonProfileAvatar(
            profileImageUrl: isBlocked ? '' : user.profileImageUrl,
            radius: 19,
            iconSize: 26,
          ),
          SizedBox(width: 7),
          Text(
            isBlocked ? 'Blocked user' : user.name,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      //block unblock popup
      actions: [
        !isDeleted
            ? BlockPopup(
                otherUserUid: user.uid,
                currentUserUid: currentUserUid,
                isBlocked: blockedByCurrentUser,
                bgColor: Theme.of(context).scaffoldBackgroundColor,
              )
            : SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

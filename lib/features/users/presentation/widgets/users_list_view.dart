import 'package:chat_app/core/widgets/common_profile_avatar.dart';
import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/presentation/pages/message_page.dart';
import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:flutter/material.dart';

class UsersListView extends StatelessWidget {
  final List<AppUserModel> users;

  const UsersListView({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentUserUid = AuthService().currentUserUid;

    //filtering current user + blocked list
    final usersList = users.where((user) {
      return user.uid != currentUserUid &&
          !user.blockedUserIds.contains(currentUserUid);
    }).toList();

    //Empty users
    if (usersList.isEmpty) {
      return Center(
        child: Text('No users found', style: TextStyle(color: Colors.grey)),
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        final user = usersList[index];

        //list tile
        return ListTile(
          //navigate to chat page
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MessagePage(
                user: user,
                isDeleted: false,
                blockedByCurrentUser: false,
                blockedByOtherUser: false,
              ),
            ),
          ),
          //profile image
          leading: CommonProfileAvatar(profileImageUrl: user.profileImageUrl),
          //user name
          title: Text(user.name),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: theme.disabledColor,
            size: 18,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(indent: 78, thickness: 0.1);
      },
      itemCount: usersList.length,
    );
  }
}

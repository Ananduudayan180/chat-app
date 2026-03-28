import 'package:chat_app/core/widgets/common_profile_avatar.dart';
import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:flutter/material.dart';

class UsersListView extends StatelessWidget {
  final List<AppUserModel> users;
  const UsersListView({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final currentUserUid = AuthService().currentUserUid;
    final theme = Theme.of(context);
    return ListView.separated(
      itemBuilder: (context, index) {
        //filtering
        final usersList = users.where((user) {
          return user.uid != currentUserUid;
        }).toList();

        //Empty users
        if (usersList.isEmpty) {
          return Text('No users found');
        }
        final user = usersList[index];

        //list tile
        return ListTile(
          onTap: () {
            //navigate to chat
          },
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
      itemCount: users.length - 1,
    );
  }
}

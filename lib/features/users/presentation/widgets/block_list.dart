import 'package:chat_app/core/widgets/common_profile_avatar.dart';
import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/profile/data/service/profile_firestore_service.dart';
import 'package:chat_app/features/users/presentation/widgets/block_popup.dart';
import 'package:flutter/material.dart';

class BlockList extends StatelessWidget {
  final List<String> blockedUserIds;
  const BlockList({super.key, required this.blockedUserIds});

  @override
  Widget build(BuildContext context) {
    final profileService = ProfileFirestoreService();
    final currentUserUid = AuthService().currentUserUid;
    return ListView.separated(
      itemCount: blockedUserIds.length,
      itemBuilder: (context, index) {
        final blockedUserId = blockedUserIds[index];
        return FutureBuilder(
          future: profileService.fetchUserProfile(blockedUserId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final profile = snapshot.data;
              return ListTile(
                leading: CommonProfileAvatar(
                  profileImageUrl: profile!.profileImageUrl,
                ),
                title: Text(profile.name),
                //unblock
                trailing: BlockPopup(
                  otherUserUid: profile.uid,
                  currentUserUid: currentUserUid,
                  isBlocked: true,
                  bgColor: Theme.of(context).colorScheme.surface,
                ),
              );
            }
            return SizedBox();
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(indent: 78, thickness: 0.1);
      },
    );
  }
}

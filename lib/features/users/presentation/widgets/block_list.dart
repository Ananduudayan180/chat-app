import 'package:chat_app/core/widgets/common_profile_avatar.dart';
import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/profile/data/service/profile_firestore_service.dart';
import 'package:chat_app/features/users/presentation/bloc/block/block_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BlockList extends StatelessWidget {
  final List<String> blockedUserIds;
  const BlockList({super.key, required this.blockedUserIds});

  @override
  Widget build(BuildContext context) {
    final profileService = ProfileFirestoreService();
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
                trailing: MenuAnchor(
                  style: MenuStyle(
                    alignment: Alignment(8, 1),
                    padding: WidgetStateProperty.all(EdgeInsetsGeometry.zero),
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.surface,
                    ),
                    elevation: const WidgetStatePropertyAll(8),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  builder: (context, controller, child) {
                    return IconButton(
                      onPressed: () => controller.isOpen
                          ? controller.close()
                          : controller.open(),
                      icon: Icon(Icons.more_vert_outlined),
                    );
                  },
                  menuChildren: [
                    MenuItemButton(
                      leadingIcon: FaIcon(FontAwesomeIcons.unlock, size: 18),
                      child: Text('Unblock'),
                      onPressed: () => context.read<BlockBloc>().add(
                        UnblockUser(
                          currentUserUid: AuthService().currentUserUid,
                          otherUserUid: profile.uid,
                        ),
                      ),
                    ),
                  ],
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

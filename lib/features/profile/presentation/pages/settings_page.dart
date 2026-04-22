import 'package:chat_app/features/profile/presentation/widgets/my_list_tile.dart';
import 'package:chat_app/features/users/presentation/pages/blocked_users_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: MyListTile(
          title: 'Blocked users',
          onTap: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => BlockedUsersPage())),
          leadingIcon: Icons.person_off,
          divider: false,
        ),
      ),
    );
  }
}

import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/profile/presentation/widgets/my_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettingsBox extends StatelessWidget {
  const ProfileSettingsBox({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [theme.surface, theme.surface]),
        ),
        //list tiles
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //account
            MyListTile(
              title: 'Account',
              leadingIcon: Icons.person,
              onTap: () {},
            ),
            //dark mode
            MyListTile(
              title: 'Dark mode',
              leadingIcon: Icons.dark_mode,
              trailingButton: CupertinoSwitch(
                activeTrackColor: theme.primary,
                value: true,
                onChanged: (value) {},
              ),
              onTap: null,
            ),
            //settings
            MyListTile(
              title: 'Settings',
              leadingIcon: Icons.settings,
              onTap: () {},
            ),
            //logout
            MyListTile(
              title: 'Logout',
              leadingIcon: Icons.logout,
              divider: false,
              titleColor: Colors.red,
              leadingColor: Colors.red,
              trailingColor: Colors.red,
              onTap: () => context.read<AuthBloc>().add(LogoutRequested()),
            ),
          ],
        ),
      ),
    );
  }
}

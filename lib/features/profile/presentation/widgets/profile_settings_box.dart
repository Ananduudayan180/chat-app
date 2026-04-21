import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/profile/presentation/dialog/dialogs.dart';
import 'package:chat_app/features/profile/presentation/pages/account_page.dart';
import 'package:chat_app/features/profile/presentation/pages/settings_page.dart';
import 'package:chat_app/features/profile/presentation/widgets/my_list_tile.dart';
import 'package:chat_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettingsBox extends StatelessWidget {
  final String email;
  final String currentName;
  const ProfileSettingsBox({
    super.key,
    required this.email,
    required this.currentName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    //logout dialog
    void logout() {
      Dialogs.showDialogBox(
        title: 'Logout',
        actionText: 'Logout',
        actionColor: Colors.red,
        context: context,
        content: Text('Do you want to logout?'),
        onTap: () {
          Navigator.pop(context);
          context.read<AuthBloc>().add(LogoutRequested());
        },
      );
    }

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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        AccountPage(email: email, currentName: currentName),
                  ),
                );
              },
            ),
            //dark mode
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return MyListTile(
                  title: 'Dark mode',
                  leadingIcon: state.isDark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  trailingButton: CupertinoSwitch(
                    activeTrackColor: theme.primary,
                    value: state.isDark,
                    onChanged: (value) =>
                        context.read<ThemeBloc>().add(ToggleThemeEvent()),
                  ),
                  onTap: null,
                );
              },
            ),
            //settings
            MyListTile(
              title: 'Settings',
              leadingIcon: Icons.settings,
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsPage())),
            ),
            //logout
            MyListTile(
              title: 'Logout',
              leadingIcon: Icons.logout,
              divider: false,
              titleColor: Colors.red,
              leadingColor: Colors.red,
              trailingColor: Colors.red,
              onTap: logout,
            ),
          ],
        ),
      ),
    );
  }
}

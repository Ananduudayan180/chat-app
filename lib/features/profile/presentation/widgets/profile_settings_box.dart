import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/profile/presentation/widgets/my_list_tile.dart';
import 'package:chat_app/features/theme/presentation/bloc/theme_bloc.dart';
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

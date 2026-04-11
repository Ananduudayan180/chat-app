import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyBottomBar extends StatelessWidget {
  final void Function(int index)? onTap;
  final int currentIndex;
  const MyBottomBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TooltipTheme(
      data: TooltipThemeData(
        decoration: BoxDecoration(color: Colors.transparent),
      ),
      child: NavigationBar(
        onDestinationSelected: onTap,
        selectedIndex: currentIndex,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        labelTextStyle: WidgetStatePropertyAll(TextStyle(fontSize: 0)),
        height: 65,
        destinations: [
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.message),
            selectedIcon: FaIcon(
              FontAwesomeIcons.solidMessage,
              color: theme.primary,
            ),
            label: '',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            selectedIcon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: theme.primary,
            ),
            label: '',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.user),
            selectedIcon: FaIcon(
              FontAwesomeIcons.solidUser,
              color: theme.primary,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

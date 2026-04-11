import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Widget? trailingButton;
  final VoidCallback? onTap;
  final bool divider;
  final Color? titleColor;
  final Color? leadingColor;
  final Color? trailingColor;
  const MyListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.leadingIcon,
    this.trailingButton,
    this.divider = true,
    this.titleColor,
    this.trailingColor,
    this.leadingColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          //listTile
          child: ListTile(
            onTap: onTap,
            leading: Icon(
              leadingIcon,
              color: leadingColor ?? theme.dividerColor,
            ),
            title: Text(title, style: TextStyle(color: titleColor)),
            trailing:
                trailingButton ??
                Icon(
                  Icons.arrow_forward_ios,
                  color: trailingColor ?? theme.dividerColor,
                  size: 18,
                ),
          ),
        ),
        //divider
        divider
            ? Divider(
                indent: 20,
                endIndent: 20,
                color: theme.dividerColor,
                thickness: 0.3,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

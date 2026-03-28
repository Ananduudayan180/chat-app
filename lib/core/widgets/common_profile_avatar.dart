import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommonProfileAvatar extends StatelessWidget {
  final String profileImageUrl;
  final double? radius;
  final double? iconSize;
  const CommonProfileAvatar({
    super.key,
    required this.profileImageUrl,
    this.radius = 25,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.surface,
        gradient: LinearGradient(
          colors: [theme.colorScheme.surface, theme.colorScheme.surface],
        ),
        //big container border
        border: Border.all(width: 2, color: theme.dividerColor),
      ),
      //circle avatar
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        //profile image
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: profileImageUrl,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Icon(Icons.person, size: iconSize, color: theme.dividerColor),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}

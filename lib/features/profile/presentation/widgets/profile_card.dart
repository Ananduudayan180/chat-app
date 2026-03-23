import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileCard extends StatelessWidget {
  final VoidCallback viewPic;
  final VoidCallback changePic;
  final ProfileModel profile;
  const ProfileCard({
    super.key,
    required this.viewPic,
    required this.changePic,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        //appBar
        AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        //stack
        Stack(
          children: [
            //BIG CONTAINER - view profile pic
            GestureDetector(
              onTap: viewPic,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.surface,
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.surface,
                      theme.colorScheme.surface,
                    ],
                  ),
                  //big container border
                  border: Border.all(width: 2, color: theme.dividerColor),
                ),
                //circle avatar
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  //profile image
                  child: CachedNetworkImage(
                    imageUrl: profile.profilePic,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.person, size: 90, color: theme.dividerColor),
                    fit: BoxFit.cover,
                    // width: 140,
                    // height: 140,
                  ),
                ),
              ),
            ),
            //SMALL CONTAINER - edit profile pic
            Positioned(
              bottom: 15,
              right: 10,
              child: GestureDetector(
                onTap: changePic,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary,
                    border: Border.all(width: 2, color: theme.dividerColor),
                  ),
                  padding: EdgeInsets.all(4),
                  child: FaIcon(
                    FontAwesomeIcons.pen,
                    size: 16,
                    // color: theme.dividerColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          profile.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(profile.email, style: TextStyle(color: theme.dividerColor)),
      ],
    );
  }
}

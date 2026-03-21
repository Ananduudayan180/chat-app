import 'package:chat_app/features/profile/presentation/widgets/profile_card.dart';
import 'package:chat_app/features/profile/presentation/widgets/profile_settings_box.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //profile card
            ProfileCard(viewPic: () {}, changePic: () {}),
            //profile settings container
            ProfileSettingsBox(),
          ],
        ),
      ),
    );
  }
}

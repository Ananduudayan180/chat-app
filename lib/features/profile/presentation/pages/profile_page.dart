import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:chat_app/features/profile/presentation/widgets/profile_card.dart';
import 'package:chat_app/features/profile/presentation/widgets/profile_settings_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final AuthService _auth = AuthService();

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUserUid;
    context.read<ProfileBloc>().add(FetchProfileRequested(uid: uid));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        //Error
        if (state is ProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        //Loaded
        if (state is ProfileLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //profile card
                  ProfileCard(
                    viewPic: () {},
                    changePic: () {},
                    profile: state.profile,
                  ),
                  //profile settings container
                  ProfileSettingsBox(),
                ],
              ),
            ),
          );
        }
        //Loading or Initial
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:chat_app/core/dialog/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewProfileImage extends StatelessWidget {
  final String profileImageUrl;
  const ViewProfileImage({super.key, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    //delete image
    void deleteProfileImage() {
      Dialogs.showDialogBox(
        title: 'Delete image',
        actionText: 'Delete',
        actionColor: Colors.red,
        context: context,
        content: Text('Do you want to delete the image?'),
        onTap: () {
          Navigator.pop(context);
          context.read<ProfileBloc>().add(
            DeleteProfileImage(currentUserUid: AuthService().currentUserUid),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //Back button
        leading: IconButton(
          padding: EdgeInsets.symmetric(horizontal: 24),
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: IconButton(
              onPressed: deleteProfileImage,
              icon: Icon(Icons.delete_outline),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
          if (state is ProfileLoaded) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: SizedBox(
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: profileImageUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.person, size: 100, color: Colors.grey[500]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

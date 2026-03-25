import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:chat_app/features/profile/presentation/pages/preview_page.dart';
import 'package:chat_app/features/profile/presentation/widgets/profile_card.dart';
import 'package:chat_app/features/profile/presentation/widgets/profile_settings_box.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final AuthService _auth = AuthService();

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? bytes;
  String? path;
  //Pick image
  Future<void> pickImage() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    //if null
    if (file == null) return;

    //create fileName
    final pickeFile = file.files.first;
    final pickedFileName = pickeFile.name;
    final fileName =
        '${_auth.currentUserUid}${DateTime.now().millisecondsSinceEpoch}$pickedFileName';

    if (kIsWeb) {
      bytes = file.files.first.bytes;
    } else {
      path = file.files.first.path;
    }

    //image priview
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PreviewPage(
          bytes: bytes,
          path: path,
          uid: _auth.currentUserUid,
          fileName: fileName,
        ),
      ),
    );
  }

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
                    changePic: pickImage,
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

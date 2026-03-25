import 'dart:io';
import 'dart:typed_data';
import 'package:chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewPage extends StatelessWidget {
  final Uint8List? bytes;
  final String? path;
  final String uid;
  final String fileName;
  const PreviewPage({
    super.key,
    this.bytes,
    this.path,
    required this.uid,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 24),
        backgroundColor: Colors.transparent,
        //Back button
        leading: IconButton(
          padding: EdgeInsets.symmetric(horizontal: 24),
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          //Select button
          ElevatedButton(
            onPressed: () {
              //upload profile image
              context.read<ProfileBloc>().add(
                UploadProfileImage(
                  bytes: bytes,
                  path: path,
                  fileName: fileName,
                  uid: uid,
                ),
              );
              // pop
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text('Select', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
      //body
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: bytes != null
              ? Image.memory(bytes!, fit: BoxFit.cover)
              : path != null
              ? Image.file(File(path!), fit: BoxFit.cover)
              : Text('No image selected'),
        ),
      ),
    );
  }
}

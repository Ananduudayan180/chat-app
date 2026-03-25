import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  final Uint8List? bytes;
  final String? path;
  const PreviewPage({super.key, this.bytes, this.path});

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
            onPressed: () {},
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
        child: bytes != null
            ? Image.memory(bytes!, fit: BoxFit.contain)
            : path != null
            ? Image.file(File(path!))
            : Text('No image selected'),
      ),
    );
  }
}

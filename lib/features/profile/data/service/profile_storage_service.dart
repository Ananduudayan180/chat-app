import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileStorageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> uploadProfileImage({
    Uint8List? bytes,
    String? path,
    required String fileName,
  }) async {
    try {
      if (path != null) {
        return await _uploadImagePath(fileName, path, 'profile_images');
      } else if (bytes != null) {
        return await _uploadImageBytes(fileName, bytes, 'profile_images');
      } else {
        throw Exception('No image data');
      }
    } on Exception catch (e) {
      throw Exception('Upload failed $e');
    }
  }

  //HELPER FUNCTIONS
  //mobile - desktop upload
  Future<String> _uploadImagePath(
    String fileName,
    String path,
    String bucketId,
  ) async {
    File file = File(path);
    await _supabase.storage
        .from(bucketId)
        .upload(fileName, file, fileOptions: const FileOptions(upsert: true));
    final url = _supabase.storage.from(bucketId).getPublicUrl(fileName);
    return url;
  }

  //web upload
  Future<String> _uploadImageBytes(
    String fileName,
    Uint8List bytes,
    String bucketId,
  ) async {
    await _supabase.storage
        .from(bucketId)
        .uploadBinary(
          fileName,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );
    final url = _supabase.storage.from(bucketId).getPublicUrl(fileName);
    return url;
  }
}

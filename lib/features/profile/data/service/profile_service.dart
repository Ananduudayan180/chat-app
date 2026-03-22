import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProfileModel?> fetchUserProfile(String uid) async {
    try {
      final userData = await _firestore
          .collection('user_profiles')
          .doc(uid)
          .get();

      if (userData.exists) {
        final user = userData.data();
        if (user == null) return null;

        return ProfileModel(
          uid: user['uid'],
          name: user['name'],
          email: user['email'],
          profilePic: user['profile_pic'] ?? '',
        );
      }
      return null;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}

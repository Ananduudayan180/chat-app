import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //fetch user profile
  Future<ProfileModel?> fetchUserProfile(String uid) async {
    try {
      final userData = await _firestore.collection('users').doc(uid).get();

      if (userData.exists) {
        final user = userData.data();
        if (user == null) return null;

        return ProfileModel(
          uid: user['uid'],
          name: user['name'],
          email: user['email'],
          profileImageUrl: user['profileImageUrl'] ?? '',
        );
      }
      return null;
    } on Exception catch (e) {
      throw Exception('Failed to fetch user profile $e');
    }
  }

  //update profile image
  Future<void> updateProfileImage(String url, String uid) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'profileImageUrl': url,
      }, SetOptions(merge: true));
    } on Exception {
      throw Exception('Update profile failed');
    }
  }

  //update name
  Future<ProfileModel?> updateUserName(
    String currentUserUid,
    String newName,
  ) async {
    try {
      await _firestore.collection('users').doc(currentUserUid).update({
        'name': newName,
      });
      final userData = await _firestore
          .collection('users')
          .doc(currentUserUid)
          .get();

      if (userData.exists) {
        final doc = userData.data();
        if (doc != null) {
          return ProfileModel(
            uid: doc['uid'],
            name: doc['name'],
            email: doc['email'],
            profileImageUrl: doc['profileImageUrl'] ?? '',
          );
        }
      }

      return null;
    } catch (e) {
      throw Exception('Failed to update name $e');
    }
  }

  Future<void> deleteProfileImage(String currentUserUid) async {
    try {
      await _firestore.collection('users').doc(currentUserUid).update({
        'profileImageUrl': FieldValue.delete(),
      });
    } catch (e) {
      throw Exception('Failed to delete profile image $e');
    }
  }
}

import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //fetch all app users
  Future<List<AppUserModel>> fetchUsers() async {
    try {
      final usersCollection = await _firestore.collection('users').get();

      final usersDocs = usersCollection.docs;

      return usersDocs.map((doc) {
        final user = doc.data();
        return AppUserModel(
          uid: user['uid'],
          name: user['name'],
          profileImageUrl: user['profileImageUrl'] ?? '',
          blockedUserIds: List<String>.from(user['blockedUserIds'] ?? []),
        );
      }).toList();
    } on Exception catch (e) {
      throw Exception('Failed to fetch users $e');
    }
  }

  //fetch one user
  Future<AppUserModel?> fetchUser(String uid) async {
    try {
      final usersDoc = await _firestore.collection('users').doc(uid).get();

      if (usersDoc.exists && usersDoc.data() != null) {
        final user = usersDoc.data()!;
        return AppUserModel(
          uid: user['uid'],
          name: user['name'],
          profileImageUrl: user['profileImageUrl'] ?? '',
          blockedUserIds: List<String>.from(user['blockedUserIds'] ?? []),
        );
      }
      return null;
    } on Exception catch (e) {
      throw Exception('Failed to fetch user $e');
    }
  }

  //block user
  Future<void> blockUser(String currentUserUid, String otherUserUid) async {
    try {
      await _firestore.collection('users').doc(currentUserUid).update({
        'blockedUserIds': FieldValue.arrayUnion([otherUserUid]),
      });
    } catch (e) {
      throw Exception('Failed to block user');
    }
  }

  //unblock user
  Future<void> unblockUser(String currentUserUid, String otherUserUid) async {
    try {
      await _firestore.collection('users').doc(currentUserUid).update({
        'blockedUserIds': FieldValue.arrayRemove([otherUserUid]),
      });
    } catch (e) {
      throw Exception('Failed to unblock user');
    }
  }

  //fetch blocked user ids
  Future<List<String>> getBlockedUserIds(String currentUserUid) async {
    try {
      final userDoc = await _firestore
          .collection('users')
          .doc(currentUserUid)
          .get();

      if (userDoc.exists) {
        final user = userDoc.data();
        if (user != null) {
          final List<String> blockedUserIds = List<String>.from(
            user['blockedUserIds'] ?? [],
          );
          return blockedUserIds;
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch blocked users');
    }
  }
}

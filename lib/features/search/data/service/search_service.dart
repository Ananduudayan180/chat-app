import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<AppUserModel>> searchUsers(String query) async {
    try {
      final usersCollection = await _firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .get();
      if (usersCollection.docs.isEmpty) return [];

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
    } catch (e) {
      throw Exception('Failed to search $e');
    }
  }
}

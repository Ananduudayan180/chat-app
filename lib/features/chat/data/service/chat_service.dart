import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<ChatModel>> streamChats() {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: AuthService().currentUserUid)
        .orderBy('lastMsgTime', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final chat = doc.data();
            final List participants = chat['participants'];
            final otherUserUid = participants.firstWhere((uid) {
              final currentUserUid = AuthService().currentUserUid;
              return uid != currentUserUid;
            });
            return ChatModel.fromJson(chat, otherUserUid);
          }).toList();
        });
  }

  Future<void> updateMetaChat(
    ChatModel chat,
    String chatId,
    List<String> participants,
  ) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .set(chat.toJson(participants), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to update meta chat $e');
    }
  }

  Future<void> deleteChat(String chatId, String currentUserUid) async {
    try {
      await _firestore.collection('chats').doc(chatId).update({
        'visibleFor': FieldValue.arrayRemove([currentUserUid]),
        'deletedAt.$currentUserUid': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to delete chat');
    }
  }
}

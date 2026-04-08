import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<ChatModel>> streamChats(String currentUserUid) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserUid)
        .orderBy('lastMsgTime', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final chat = doc.data();
            final List participants = chat['participants'];
            final otherUserUid = participants.firstWhere((uid) {
              return uid != currentUserUid;
            });
            return ChatModel.fromJson(chat, otherUserUid);
          }).toList();
        });
  }
}

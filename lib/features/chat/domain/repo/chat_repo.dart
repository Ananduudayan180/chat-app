import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:chat_app/features/chat/domain/entity/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepo {
  Stream<List<ChatModel>> streamChats();
  Stream<List<MessageModel>> streamMessages(
    String chatId,
    Timestamp lastDeletedAt,
  );
  Future<void> saveMessage(
    MessageModel message,
    String chatId,
    List<String> participants,
  );
  Future<void> deleteChat(String chatId, String currentUserUid);
  Future<Timestamp> getChatDeleteTimestamp(String chatId);
}

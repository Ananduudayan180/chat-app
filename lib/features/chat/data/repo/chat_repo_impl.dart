import 'package:chat_app/features/chat/data/service/chat_service.dart';
import 'package:chat_app/features/chat/data/service/message_service.dart';
import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:chat_app/features/chat/domain/entity/message_model.dart';
import 'package:chat_app/features/chat/domain/repo/chat_repo.dart';

class ChatRepoImpl extends ChatRepo {
  final ChatService _chatService;
  final MessageService _messageService;

  ChatRepoImpl({
    required ChatService chatService,
    required MessageService messageService,
  }) : _messageService = messageService,
       _chatService = chatService;

  @override
  Stream<List<ChatModel>> streamChats(String currentUserUid) =>
      _chatService.streamChats(currentUserUid);

  @override
  Stream<List<MessageModel>> streamMessages(String chatId) =>
      _messageService.streamMessages(chatId);

  @override
  Future<void> saveMessage(
    MessageModel message,
    String chatId,
    List<String> participants,
  ) async {
    final chat = ChatModel(
      chatId: chatId,
      lastMsg: message.text,
      unreadCount: 0,
      lastMsgTime: message.createdAt,
      lastMsgSenderId: message.senderId,
    );
    await _chatService.updateMetaChat(chat, chatId, participants);
    await _messageService.saveMessage(message, chatId);
  }
}

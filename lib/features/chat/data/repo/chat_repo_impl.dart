import 'package:chat_app/features/chat/data/service/chat_service.dart';
import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:chat_app/features/chat/domain/repo/chat_repo.dart';

class ChatRepoImpl extends ChatRepo {
  final ChatService _chatService;

  ChatRepoImpl({required ChatService chatService}) : _chatService = chatService;

  @override
  Stream<List<ChatModel>> streamChats(String currentUserUid) =>
      _chatService.streamChats(currentUserUid);
}

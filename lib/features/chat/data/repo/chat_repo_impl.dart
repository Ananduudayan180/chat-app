import 'package:chat_app/features/chat/data/service/chat_service.dart';
import 'package:chat_app/features/chat/domain/repo/chat_repo.dart';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatService _chatService;

  ChatRepoImpl({required ChatService chatService}) : _chatService = chatService;
  @override
  Future<List<ProfileModel>> fetchAllUsers() => _chatService.fetchAllUsers();
}

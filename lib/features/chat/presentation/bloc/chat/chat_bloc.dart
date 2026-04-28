import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/chat/domain/entity/chat_model.dart';
import 'package:chat_app/features/chat/domain/repo/chat_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo _chatRepo;
  ChatBloc({required ChatRepo chatRepo})
    : _chatRepo = chatRepo,
      super(ChatInitial()) {
    //stream chats
    on<StreamChatsEvent>((event, emit) async {
      await emit.forEach(
        _chatRepo.streamChats(),
        onData: (chatList) {
          final chats = chatList.where((chat) {
            return chat.visibleFor.contains(AuthService().currentUserUid);
          }).toList();
          return ChatLoaded(chats: chats);
        },
        onError: (error, stackTrace) => ChatError(errorMsg: error.toString()),
      );
    });

    //delete chat
    on<DeleteChatEvent>((event, emit) async {
      try {
        await _chatRepo.deleteChat(event.chatId, event.currentUserUid);
      } on Exception catch (e) {
        emit(ChatError(errorMsg: e.toString()));
      }
    });
  }
}

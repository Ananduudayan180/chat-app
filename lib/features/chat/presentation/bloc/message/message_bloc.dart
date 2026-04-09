import 'package:chat_app/features/chat/domain/entity/message_model.dart';
import 'package:chat_app/features/chat/domain/repo/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final ChatRepo _chatRepo;
  MessageBloc({required ChatRepo chatRepo})
    : _chatRepo = chatRepo,
      super(MessageInitial()) {
    //stream msg
    on<StreamMessageEvent>((event, emit) async {
      emit(MessageLoading());
      await emit.forEach(
        _chatRepo.streamMessages(event.chatId),
        onData: (messages) => MessageLoaded(messages: messages),
        onError: (error, stackTrace) =>
            MessageError(errorMsg: error.toString()),
      );
    });

    //send message
    on<SaveMessageEvent>((event, emit) async {
      try {
        await _chatRepo.saveMessage(
          event.message,
          event.chatId,
          event.participants,
        );
      } on Exception catch (e) {
        emit(MessageError(errorMsg: e.toString()));
      }
    });
  }
}

part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<ChatModel> chats;

  ChatLoaded({required this.chats});
}

final class ChatError extends ChatState {
  final String errorMsg;

  ChatError({required this.errorMsg});
}

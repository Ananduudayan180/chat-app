part of 'block_bloc.dart';

@immutable
sealed class BlockEvent {}

final class BlockUser extends BlockEvent {
  final String currentUserUid;
  final String otherUserUid;

  BlockUser({required this.currentUserUid, required this.otherUserUid});
}

final class UnblockUser extends BlockEvent {
  final String currentUserUid;
  final String otherUserUid;

  UnblockUser({required this.currentUserUid, required this.otherUserUid});
}

final class GetBlockedUserIds extends BlockEvent {
  final String currentUserUid;

  GetBlockedUserIds({required this.currentUserUid});
}

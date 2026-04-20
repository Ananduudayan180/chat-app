import 'package:chat_app/features/users/domain/repo/users_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'block_event.dart';
part 'block_state.dart';

class BlockBloc extends Bloc<BlockEvent, BlockState> {
  final UsersRepo _usersRepo;
  BlockBloc({required UsersRepo usersRepo})
    : _usersRepo = usersRepo,
      super(BlockInitial()) {
    //block
    on<BlockUser>((event, emit) async {
      emit(BlockLoading());
      try {
        await _usersRepo.blockUser(event.currentUserUid, event.otherUserUid);
        emit(
          BlockSuccess(
            successMsg: 'User blocked successfully',
            isBlocked: true,
          ),
        );
      } on Exception catch (e) {
        emit(BlockError(errorMsg: e.toString()));
      }
    });

    //unblock
    on<UnblockUser>((event, emit) async {
      emit(BlockLoading());
      try {
        await _usersRepo.unblockUser(event.currentUserUid, event.otherUserUid);
        emit(
          BlockSuccess(
            successMsg: 'User unblocked successfully',
            isBlocked: false,
          ),
        );
      } on Exception catch (e) {
        emit(BlockError(errorMsg: e.toString()));
      }
    });
  }
}

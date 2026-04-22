import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:chat_app/features/users/domain/repo/users_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepo _usersRepo;
  UsersBloc({required UsersRepo usersRepo})
    : _usersRepo = usersRepo,
      super(UsersInitial()) {
    //fetch app users
    on<FetchUsers>((event, emit) async {
      emit(UsersLoading());
      try {
        final users = await _usersRepo.fetchUsers();
        final blockedUsersIds = await _usersRepo.getBlockedUserIds(
          event.currentUserUid,
        );
        //filtering
        final unblockedUsers = users.where((user) {
          return !blockedUsersIds.contains(user.uid);
        }).toList();
        emit(UsersLoaded(users: unblockedUsers));
      } catch (e) {
        emit(UsersError(errorMsg: e.toString()));
      }
    });
  }
}

import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/search/domain/repo/search_repo.dart';
import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:chat_app/features/users/domain/repo/users_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo _searchRepo;
  final UsersRepo _usersRepo;
  final currentUserUid = AuthService().currentUserUid;

  SearchBloc({required SearchRepo searchRepo, required UsersRepo usersRepo})
    : _usersRepo = usersRepo,
      _searchRepo = searchRepo,
      super(SearchInitial()) {
    on<SearchUsers>(
      transformer: (events, mapper) {
        return events.debounce(Duration(milliseconds: 300)).switchMap(mapper);
      },
      //logic
      (event, emit) async {
        if (event.query.trim().isEmpty) {
          emit(SearchInitial());
          return;
        }
        try {
          emit(SearchLoading());
          final usersList = await _searchRepo.searchUsers(event.query);
          final myBlockedUsersIds = await _usersRepo.getBlockedUserIds(
            currentUserUid,
          );
          //filtering unblocked users
          final users = usersList
              .where((user) => !myBlockedUsersIds.contains(user.uid))
              .toList();
          emit(SearchLoaded(users: users));
        } on Exception catch (e) {
          emit(SearchError(errorMsg: e.toString()));
        }
      },
    );
  }
}

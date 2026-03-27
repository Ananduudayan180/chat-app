import 'package:chat_app/features/users/data/service/users_service.dart';
import 'package:chat_app/features/users/domain/entity/app_user_model.dart';
import 'package:chat_app/features/users/domain/repo/users_repo.dart';

class UsersRepoImpl implements UsersRepo {
  final UsersService _usersService;

  UsersRepoImpl({required UsersService userService})
    : _usersService = userService;
  @override
  Future<List<AppUserModel>> fetchUsers() => _usersService.fetchUsers();
}

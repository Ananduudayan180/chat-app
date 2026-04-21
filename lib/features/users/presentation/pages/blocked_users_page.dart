import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/users/presentation/bloc/block/block_bloc.dart';
import 'package:chat_app/features/users/presentation/bloc/users/users_bloc.dart';
import 'package:chat_app/features/users/presentation/widgets/block_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockedUsersPage extends StatefulWidget {
  const BlockedUsersPage({super.key});

  @override
  State<BlockedUsersPage> createState() => _BlockedUsersPageState();
}

class _BlockedUsersPageState extends State<BlockedUsersPage> {
  final currentUserUid = AuthService().currentUserUid;
  @override
  void initState() {
    super.initState();
    final state = context.read<BlockBloc>().state;
    if (state is BlockedUserIdsLoaded) return;
    context.read<BlockBloc>().add(
      GetBlockedUserIds(currentUserUid: AuthService().currentUserUid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: Text('Blocked users', style: TextStyle(fontSize: 20)),
      ),
      body: BlocConsumer<BlockBloc, BlockState>(
        buildWhen: (previous, current) => current is BlockedUserIdsLoaded,
        listener: (context, state) {
          if (state is BlockError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
          if (state is BlockSuccess) {
            context.read<BlockBloc>().add(
              GetBlockedUserIds(currentUserUid: currentUserUid),
            );
            context.read<UsersBloc>().add(
              FetchUsers(currentUserUid: currentUserUid),
            );
          }
        },
        builder: (context, state) {
          if (state is BlockedUserIdsLoaded) {
            if (state.blockedUserIds.isEmpty) {
              return Center(
                child: Text(
                  'No blocked users yet',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
            return BlockList(blockedUserIds: state.blockedUserIds);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

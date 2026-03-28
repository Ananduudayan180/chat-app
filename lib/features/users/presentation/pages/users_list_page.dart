import 'package:chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:chat_app/features/users/presentation/widgets/users_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  @override
  void initState() {
    super.initState();
    final state = context.read<UsersBloc>().state;
    if (state is UsersLoaded) return;
    //call fetch user event
    context.read<UsersBloc>().add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: Text(
          'New Chat',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      //body
      body: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          //Error
          if (state is UsersError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
        },
        builder: (context, state) {
          //loaded
          if (state is UsersLoaded) {
            return UsersListView(users: state.users);
          }
          //loading & initial
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

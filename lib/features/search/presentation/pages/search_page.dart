import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:chat_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:chat_app/features/users/presentation/widgets/users_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchController.addListener(searchQuery);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchQuery() {
    context.read<SearchBloc>().add(SearchUsers(query: searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Search',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          //search textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: MyTextField(
              controller: searchController,
              hintText: 'Search',
              validator: null,
            ),
          ),
          BlocConsumer<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
              }
            },
            builder: (context, state) {
              if (state is SearchLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is SearchLoaded) {
                return Expanded(child: UsersListView(users: state.users));
              }
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/search.svg', width: 250),
                      Text('Find users', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

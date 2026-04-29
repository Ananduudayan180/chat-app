import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //appbar
        AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Search',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              //search textfield
              MyTextField(
                controller: searchController,
                hintText: 'Search',
                validator: null,
              ),
              //svg
              Center(
                heightFactor: 2,
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svg/search.svg', width: 250),
                    Text('Find users', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),

        //svg
      ],
    );
  }
}

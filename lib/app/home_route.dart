import 'package:chat_app/core/widgets/my_bottom_bar.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_list_page.dart';
import 'package:chat_app/features/profile/presentation/pages/profile_page.dart';
import 'package:chat_app/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

int currentIndex = 0;

class _HomeRouteState extends State<HomeRoute> {
  final List<Widget> pages = [
    const ChatListPage(),
    const SettingsPage(),
    const ProfilePage(),
  ];
  //switch pages
  void switchPages(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //my bottom bar
      bottomNavigationBar: MyBottomBar(onTap: switchPages),
      body: IndexedStack(index: currentIndex, children: pages),
    );
  }
}

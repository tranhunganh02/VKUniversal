import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/features/chat/presentation/pages/list_chat.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/newsfeed.dart';
import 'package:vkuniversal/features/profile/presentation/pages/profile_draft.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectIndex = 0;

  final List<Widget> _pages = [
    NewsfeedPage(),
    Container(
      color: Colors.blue,
    ),
    ListChatScreen(),
    ProfilePage(),
    Container(
      color: Colors.brown,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    // final width = ScreenScale(context: context).getWidth();
    return Scaffold(
      body: _pages[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        onTap: (index) => {
          setState(() {
            _selectIndex = index;
          })
        },
        currentIndex: _selectIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                _selectIndex == 0 ? IconList.home_solid : IconList.home_outline,
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _selectIndex == 1
                ? IconList.marketplace_solid
                : IconList.marketplace_outline,
            label: "",
          ),
          BottomNavigationBarItem(
            icon:
                _selectIndex == 2 ? IconList.chat_solid : IconList.chat_outline,
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _selectIndex == 3
                ? IconList.person_solid
                : IconList.person_outline,
            label: "",
          ),
          BottomNavigationBarItem(
            icon:
                _selectIndex == 4 ? IconList.menu_solid : IconList.menu_outline,
            label: "",
          ),
        ],
      ),
    );
  }
}

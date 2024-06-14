import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/features/chat/presentation/pages/list_chat.dart';
import 'package:vkuniversal/features/menu/presentation/pages/menu.dart';
import 'package:vkuniversal/features/newsfeed/presentation/pages/newsfeed.dart';
import 'package:vkuniversal/features/profile/presentation/pages/profile_draft.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  final List<Widget> _pages = [
    NewsfeedPage(),
    Container(
      color: Colors.blue,
    ),
    ListChatScreen(),
    ProfilePage(),
    MenuPage(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _shouldShowBottomNavigationBar() {
      return (_pages[_selectedIndex] is NewsfeedPage ||
          _pages[_selectedIndex] is Container ||
          _pages[_selectedIndex] is ListChatScreen ||
          _pages[_selectedIndex] is ProfilePage ||
          _pages[_selectedIndex] is MenuPage);
    }

    return Scaffold(
      key: _scaffoldKey,
      body: PageStorage(
        bucket: _bucket,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: _shouldShowBottomNavigationBar()
          ? BottomNavigationBar(
              enableFeedback: true,
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: _selectedIndex == 0
                      ? IconList.home_solid
                      : IconList.home_outline,
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 1
                      ? IconList.marketplace_solid
                      : IconList.marketplace_outline,
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 2
                      ? IconList.chat_solid
                      : IconList.chat_outline,
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 3
                      ? IconList.person_solid
                      : IconList.person_outline,
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 4
                      ? IconList.menu_solid
                      : IconList.menu_outline,
                  label: "",
                ),
              ],
            )
          : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';

class NewsfeedPage extends StatefulWidget {
  const NewsfeedPage({super.key});

  @override
  State<NewsfeedPage> createState() => _NewsfeedPageState();
}

class _NewsfeedPageState extends State<NewsfeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: IconList.home, label: "Home"),
          BottomNavigationBarItem(icon: IconList.home, label: "Home"),
          BottomNavigationBarItem(icon: IconList.home, label: "Home"),
        ],
      ),
    );
  }
}

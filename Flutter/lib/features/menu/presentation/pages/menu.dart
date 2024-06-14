import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/features/menu/presentation/widgets/logout_alert.dart';
import 'package:vkuniversal/features/menu/presentation/widgets/menu_item.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    final List<MenuItem> items = [
      MenuItem(
        icon: IconList.user,
        title: "View Account",
        onTapFunction: () {},
      ),
      MenuItem(
        icon: IconList.logout,
        title: "Logout",
        onTapFunction: () => showDialog(
            context: context, builder: (BuildContext context) => LogoutAlert()),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          height: ScreenScale(context: context).getHeight(),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: items[index].icon,
                title: Text(items[index].title),
                onTap: () => items[index].onTapFunction(),
              );
            },
          ),
        ),
      ),
    );
  }
}

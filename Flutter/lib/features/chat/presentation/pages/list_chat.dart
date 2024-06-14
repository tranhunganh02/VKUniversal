import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import '../../../../config/routes/router_name.dart';
import '../../../../core/widgets/avatat.dart';
import '../widgets/circle_green.dart';
import '../widgets/tile_chat_user.dart';
import '../widgets/user_name.dart';
import 'data_fake.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _isSearching = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void navigateToChat() {
    Navigator.pushNamed(context, RoutesName.roomChat);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chat",
                      style: textTheme.displayMedium,
                    ),
                    SizedBox(
                      height: 45,
                      width: 201,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: TextField(
                                controller: _searchController,
                                style: textTheme.displaySmall,
                                decoration: InputDecoration(
                                  suffixIcon: _isSearching
                                      ? IconButton(
                                          onPressed: () {
                                            _searchController.clear();
                                          },
                                          icon: IconList.del,
                                        )
                                      : IconList.search,
                                  border: InputBorder.none,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  filled: false,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(bottom: 10, left: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: const Color.fromARGB(255, 190, 190, 190),
                            width: 0.5))),
                child: _isSearching
                    ? ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          width: 15,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  Avatar(users[index]["image"], 55),
                                  Positioned(
                                    bottom: 0,
                                    right: 7,
                                    child: CircleGreen(10, 10),
                                  ),
                                ],
                              ),
                              OnlineUserName(users[index]["username"])
                            ],
                          );
                        },
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(
                          width: 15,
                        ),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  Avatar(users[index]["image"], 55),
                                  Positioned(
                                    bottom: 0,
                                    right: 7,
                                    child: CircleGreen(10, 10),
                                  ),
                                ],
                              ),
                              OnlineUserName(users[index]["username"])
                            ],
                          );
                        },
                      ),
              ),
              flex: 1,
            ),
            Expanded(
              flex: 6,
              child: Container(
                  child: ListView.separated(
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  String image = messages[index]["avatar"];
                  var username = messages[index]['user_name'];
                  var last_message = messages[index]['last_message'];
                  var created_at = messages[index]['created_at'];
                  return TileUserChat(username, last_message, created_at,
                      textTheme, image, navigateToChat);
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 25,
                  child: Divider(
                    // Add Divider here
                    color: Colors.grey, // Choose your border color here
                    thickness: 0.5, // Adjust the thickness as needed
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}

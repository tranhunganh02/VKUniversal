import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/utils/injection_container.dart';
import 'package:vkuniversal/features/chat/domain/entities/receiver.dart';
import 'package:vkuniversal/features/chat/presentation/bloc/list_chat/list_chat_bloc.dart';
import '../../../../config/routes/router_name.dart';
import '../../../../core/widgets/avatat.dart';
import '../widgets/circle_green.dart';
import '../widgets/tile_chat_user.dart';
import '../widgets/user_name.dart';

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

  void navigateToChat(String idRoom, String avatar, String username) {
    Receiver rc = Receiver(idRoom, avatar, username);
    print(rc);
    Navigator.pushNamed(context, RoutesName.roomChat, arguments: rc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListChatBloc>(
      create: (context) => sl()..add(GetListChatEvent()),
      child: Scaffold(resizeToAvoidBottomInset: false, body: _body()),
    );
  }

  _body() {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ListChatBloc, ListChatState>(builder: (_, state) {
      if (state is ListChatLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is ListChatError) {
        return Center(
          child: Text(
            state.message,
            style: TextStyle(color: Colors.red),
          ),
        );
      }

      if (state is ListChatLoaded) {
        return Padding(
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
                                      borderSide:
                                          BorderSide(color: Colors.black),
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
                          itemCount: state.listChat.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Avatar(state.listChat[index].avatar!, 55),
                                    Positioned(
                                      bottom: 0,
                                      right: 7,
                                      child: CircleGreen(10, 10),
                                    ),
                                  ],
                                ),
                                OnlineUserName(
                                    state.listChat[index].username!.toString())
                              ],
                            );
                          },
                        )
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 15,
                          ),
                          itemCount: state.listChat.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Avatar(state.listChat[index].avatar!, 55),
                                    Positioned(
                                      bottom: 0,
                                      right: 7,
                                      child: CircleGreen(10, 10),
                                    ),
                                  ],
                                ),
                                OnlineUserName(state.listChat[index].username!)
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
                  itemCount: state.listChat.length,
                  itemBuilder: (BuildContext context, int index) {
                    String idRoom = state.listChat[index].documentId!;
                    String image = state.listChat[index].avatar!;
                    var username = state.listChat[index].username!;
                    var last_message = state.listChat[index].lastMessage!;
                    var created_at = state.listChat[index].createAt!;
                    return TileUserChat(
                        username,
                        last_message,
                        created_at,
                        textTheme,
                        image,
                        () => navigateToChat(
                              idRoom,
                              image,
                              username,
                            ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
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
        );
      }
      return SizedBox();
    });
  }
}

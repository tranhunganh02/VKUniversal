import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/features/chat/data/model/message.dart';
import 'package:vkuniversal/features/chat/presentation/bloc/room_chat/room_chat_bloc.dart';
import 'package:vkuniversal/features/chat/presentation/pages/data_fake.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/widgets/avatat.dart';
import '../../domain/entities/receiver.dart';
import '../widgets/chat_content.dart';

class ChatScreen extends StatefulWidget {
  final Receiver rc;
  const ChatScreen({super.key, required this.rc});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController = new ScrollController();
  TextEditingController _messageController = TextEditingController();

  int? _userId;
  @override
  void initState() {
    // TODO: implement initState
    _loadUserId();

    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  loadOldMessage(String idMessage, int userId, String message) async {
    print("dã vao2 ");
    context.read<RoomChatBloc>().add(LoadOldMessagesEvent(
          idRoom: widget.rc.idRoom,
          idMessage: idMessage,
          userId: userId,
          message: message,
        ));
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('userID');
    setState(() {
      _userId = id; // Update the state with the user ID
    });
  }

  void sendMessage(BuildContext context) {
    if (_messageController.text.isNotEmpty && _userId != null) {
      context.read<RoomChatBloc>().add(SendMessageEvent(
            idRoom: widget.rc.idRoom,
            userId: _userId!,
            message: _messageController.text,
          ));
      _messageController.clear(); // Clear the message input after sending
    } else {
      print("Message is empty or User ID is null");
    }
  }

  void scrollMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Sau khi giao diện được vẽ xong, cuộn xuống cuối danh sách
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use

    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 10),
        child: AppBar(
          centerTitle: true,
          title: Text(
            widget.rc.name,
            style: textTheme.displayMedium,
          ),
          leading: Row(
            children: [
              IconButton(
                icon: IconList.backArrow,
                onPressed: () {
                  Navigator.pop(
                      context); // Thực hiện hành động khi nút back được nhấn
                },
              ),
              Container(
                  margin: const EdgeInsets.only(left: 2.0),
                  child: Avatar(widget.rc.avatar, 45.0))
            ],
          ),
          leadingWidth: 100,
          shape: Border(
            bottom: BorderSide(
                color: Colors.grey, width: 0.5), // Add a bottom border
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Flexible(
                flex: 7,
                child: BlocProvider<RoomChatBloc>(
                    create: (context) =>
                        sl()..add(LoadMessagesEvent(idRoom: widget.rc.idRoom)),
                    child: BlocConsumer<RoomChatBloc, RoomChatState>(
                      buildWhen: (context, state) {
                        return state is ChatLoadedState;
                      },
                      builder: (_, state) {
                        if (state is ChatLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is ChatErrorState) {
                          return Center(
                            child: Text(
                              state.message,
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        if (state is ChatLoadedState) {
                          scrollMessage();
                          return ListView.builder(
                              itemCount: state.messages.length,
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                bool check =
                                    state.messages[index ].userId == _userId;
                                return ChatContent(
                                    state.messages[index ].userId,
                                    state.messages[index ].message,
                                    check);
                              });
                        }
                        return SizedBox();
                      },
                      listener: (BuildContext context, RoomChatState state) {
                        state is ChatLoadedState;
                      },
                    ))),
            Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width *
                            0.83, // Chiều rộng là 80% màn hình
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              20), // Border radius 50% của chiều cao
                          border: Border.all(
                              color: Colors.grey), // Màu và độ dày của border
                        ),
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            border: InputBorder
                                .none, // Loại bỏ border mặc định của TextField
                            hintText: 'Enter your text here',
                          ),
                          textAlign: TextAlign.justify,
                          style: textTheme.bodySmall,
                        ),
                      ),
                      GestureDetector(
                          onTap: () => sendMessage(context),
                          child: SizedBox(child: (IconList.sendMessage)))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

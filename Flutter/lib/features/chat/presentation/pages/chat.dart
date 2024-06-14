import 'package:flutter/material.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/features/chat/presentation/pages/data_fake.dart';
import '../../../../core/widgets/avatat.dart';
import '../widgets/chat_content.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();

  void sendMessage() {
    if (_messageController.text.isEmpty) {
      print("error");
    } else {
      print(_messageController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 10),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "ngoc beso",
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
                  child: Avatar(
                      "https://scontent.fdad1-4.fna.fbcdn.net/v/t39.30808-6/427931630_3730941007228005_4002607693884312382_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=5f2048&_nc_ohc=pKahOw0j4ZkQ7kNvgFkW0xf&_nc_ht=scontent.fdad1-4.fna&oh=00_AYBjZPBhQ9i1AfywfNQgXyJ4Bd5mI2kn7eKTsgi5yMHFaQ&oe=664B9F13",
                      45.0))
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
                child: Container(
                    child: ListView.builder(
                        itemCount: messagesInRoom.length,
                        itemBuilder: (context, index) {
                          var user_id = messagesInRoom[index]["user_id"];
                          var content = messagesInRoom[index]["content"];
                          return ChatContent(user_id, content);
                        }))),
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
                          onTap: sendMessage,
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

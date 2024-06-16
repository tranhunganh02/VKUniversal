import 'package:flutter/material.dart';

FractionallySizedBox ChatContent(user_id, content, bool checkSender) {
  return FractionallySizedBox(
    alignment: checkSender ? Alignment.centerRight : Alignment.centerLeft,
    widthFactor: 0.6,
    child: Align(
      alignment: checkSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: checkSender ? Colors.blue : Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          content.toString(),
          style: TextStyle(
            color: checkSender ? Colors.black : Colors.black,
          ),
        ),
      ),
    ),
  );
}

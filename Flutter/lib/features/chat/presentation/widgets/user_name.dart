import 'package:flutter/material.dart';

SizedBox OnlineUserName(String name) {
    return SizedBox(
      width: 60,
      child: Text(
        name,
        style: TextStyle(color: Colors.black),
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
    );
  }
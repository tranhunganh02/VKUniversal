
  import 'package:flutter/material.dart';

FractionallySizedBox ChatContent(user_id, content) {
    return FractionallySizedBox(
                          alignment: user_id == 1
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          widthFactor: 0.6,
                          child: Align(
                            alignment: user_id == 1
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: user_id == 1
                                    ? Colors.blue
                                    : Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                content,
                                style: TextStyle(
                                  color: user_id == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
  }

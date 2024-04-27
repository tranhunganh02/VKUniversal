import 'package:flutter/material.dart';

import '../../../../core/utils/icon_string.dart';

Padding BioUser(String email, TextTheme textTheme, String date_of_birth, String class_user) {
    return Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        
                        children: [
                          IconList.email,
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            email,
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          IconList.calender,
                          SizedBox(
                            width: 20,
                          ),
                          Text(date_of_birth, style: textTheme.bodyMedium),
                        ],
                      ),
                        SizedBox(height: 10,),
                      Row(
                        children: [
                          IconList.graduationCap,
                          SizedBox(
                            width: 20,
                          ),
                          Text(class_user, style: textTheme.bodyMedium),
                        ],
                      )
                    ],
                  ),
                );
  }
import 'package:flutter/material.dart';

bool isNotchDevice(BuildContext context) {
  var mediaQueryData = MediaQuery.of(context);
  return mediaQueryData.padding.top > 24; 
}

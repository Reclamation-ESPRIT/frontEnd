import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ignore: deprecated_member_use
MediaQueryData mediaQueryData = MediaQueryData.fromWindow(ui.window);

double width() {
  return mediaQueryData.size.width;
}

double height() {
  return mediaQueryData.size.height;
}

String baseUrl = "http://localhost:3000";

String spliteText(String text, int wordCount) {
  return text.substring(wordCount);
}

import 'package:flutter/material.dart';

Color giveCategoryGetColor(String e) {
  if (e == 'home') {
    return Colors.redAccent;
  } else if (e == 'work') {
    return Colors.greenAccent.shade700;
  } else if (e == 'code') {
    return Colors.blueAccent;
  }
  return Colors.amberAccent.shade700;
}

List<String> categoryList = ["home", "work", "code", "play"];

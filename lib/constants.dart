import 'package:flutter/material.dart';

Color giveCategoryGetColor(String e) {
  if (e == 'home') {
    return Colors.redAccent;
  } else if (e == 'work') {
    return Colors.greenAccent.shade700;
  } else if (e == 'code') {
    return Colors.blueAccent;
  } else if (e == 'play') {
    return Colors.amberAccent.shade700;
  }
  return Colors.black;
}

List<String> categoryList = ["home", "work", "code", "play"];

List<String> imageList = [
  'pencil.png',
  'travel.png',
  'takeaway-cup.png',
  'rocket.png'
];

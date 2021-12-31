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

List<String> imageList = [
  'pencil.png',
  'travel.png',
  'takeaway-cup.png',
  'rocket.png'
];
// class ToDo {
//   String task;
//   String description;
//   Enum categoryEnum;
//   bool completed;
//   Color color;
//   ToDo(this.task, this.completed, this.color, this.categoryEnum,
//       [this.description = ""]);
// }


// "Become an inspiration to others"
// "Master a difficult skill"
// "Gain a more positive mindset"
// "Learn about how to become a millionaire."
// "Go on a trip around the world."
// "Invest in the stock market"
// "Regularly call your parents"
// "Build your dream house"

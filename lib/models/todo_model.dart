import 'package:flutter/material.dart';

class ToDoModel extends ChangeNotifier {
  List<ToDo> toDoList = [
    ToDo("Become an inspiration to others", true, colorsList[0],
        categoryEnum.home, tempDescription),
    ToDo("Master a difficult skill", false, colorsList[1], categoryEnum.work,
        tempDescription),
    ToDo("Gain a more positive mindset", false, colorsList[2],
        categoryEnum.code, tempDescription),
    ToDo("Learn about how to become a millionaire.", true, colorsList[3],
        categoryEnum.play, tempDescription),
    ToDo("Go on a trip around the world.", false, colorsList[0],
        categoryEnum.home, tempDescription),
    ToDo("Invest in the stock market", false, colorsList[1], categoryEnum.work,
        tempDescription),
    ToDo("Regularly call your parents", false, colorsList[2], categoryEnum.code,
        tempDescription),
    ToDo("Build your dream house", false, colorsList[3], categoryEnum.play,
        tempDescription),
  ];

  void addToDo(String task, String description, Enum e) {
    toDoList.insert(0, ToDo(task, false, giveEnumGetColor(e), e, description));
    notifyListeners();
  }

  void removeToDoByIndex(int index) {
    toDoList.removeAt(index);
    notifyListeners();
  }

  void removeToDoByTask(String s) {
    for (ToDo x in toDoList) {
      if (x.task == s) {
        toDoList.remove(x);
      }
    }
  }

  void updateToDo(String newText, String newDescription, Enum newE, int index) {
    removeToDoByIndex(index);
    toDoList.insert(index,
        ToDo(newText, false, giveEnumGetColor(newE), newE, newDescription));
    notifyListeners();
  }

  Color giveEnumGetColor(Enum e) {
    if (e == categoryEnum.home) {
      return Colors.redAccent;
    } else if (e == categoryEnum.work) {
      return Colors.greenAccent.shade700;
    } else if (e == categoryEnum.code) {
      return Colors.blueAccent;
    }
    return Colors.amberAccent.shade700;
  }

  List<ToDo> filterListBasedOnCategory(String text) {
    return toDoList
        .where((todo) => todo.categoryEnum.name == text.toLowerCase())
        .toList();
  }
}

class ToDo {
  String task;
  String description;
  Enum categoryEnum;
  bool completed;
  Color color;
  ToDo(this.task, this.completed, this.color, this.categoryEnum,
      [this.description = ""]);
}

enum categoryEnum { home, work, code, play }

String tempDescription =
    "Flutter transforms the app development process. Build, test, and deploy beautiful mobile, web, desktop apps from a single codebase.";

List<Color> colorsList = [
  Colors.redAccent,
  Colors.greenAccent.shade700,
  Colors.blueAccent,
  Colors.amberAccent.shade700,
];

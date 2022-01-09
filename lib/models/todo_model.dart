import 'package:flutter/material.dart';

class ToDoModel {
  String task;
  String description;
  DateTime createdOn;
  bool completed;
  Color color;
  String category;

  ToDoModel({
    required this.task,
    required this.description,
    required this.createdOn,
    required this.completed,
    required this.color,
    required this.category,
  });
}

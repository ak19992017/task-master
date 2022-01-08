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

  ToDoModel.fromJson(Map<String, dynamic> parsedJson)
      : task = parsedJson['task'],
        description = parsedJson['description'],
        createdOn = parsedJson['createdOn'],
        completed = parsedJson['completed'],
        color = parsedJson['colors'],
        category = parsedJson['category'];
}

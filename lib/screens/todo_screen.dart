import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/screens/add_screen.dart';
import 'package:task_master/widgets/category.dart';
import 'package:task_master/widgets/custom_page_route.dart';
import 'package:task_master/widgets/header.dart';
import 'package:task_master/widgets/history.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            CustomPageRoute(
                child: const AddTaskScreen(), direction: AxisDirection.up),
          );
        },
        label: const Text("Add task", style: TextStyle(fontSize: 20)),
        icon: const Icon(EvaIcons.plus),
        backgroundColor: Colors.black.withOpacity(0.3),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
      ),
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 20, width: double.infinity),
            const HeaderSection(),
            const CategorySection(),
            const HistorySection(),
            const SizedBox(height: 300, child: Placeholder()),
          ],
        ),
      ),
    );
  }
}

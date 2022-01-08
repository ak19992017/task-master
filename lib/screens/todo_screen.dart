import 'package:flutter/material.dart';
import 'package:task_master/widgets/category.dart';
import 'package:task_master/widgets/drawer.dart';
import 'package:task_master/widgets/header.dart';
import 'package:task_master/widgets/all_tasks_listview.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      drawer: const SuperDrawer(),
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 20, width: double.infinity),
            const HeaderSection(),
            const CategorySection(),
            const AllTasksListViewSection(
              header: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "History",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 300, child: Placeholder()),
          ],
        ),
      ),
    );
  }
}

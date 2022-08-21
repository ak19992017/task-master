import 'package:flutter/material.dart';
import 'package:task_master/widgets/ffab.dart';
import 'package:task_master/widgets/folder.dart';
import 'package:task_master/widgets/task_list_by_date.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const SuperFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20, width: double.infinity),
            // HeaderSection(),
            const FoldersSection(),
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "History",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      // color: Colors.black87,
                    ),
                  ),
                ),
                TaskListByDate(),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_master/widgets/folder.dart';
import 'package:task_master/widgets/header.dart';
import 'package:task_master/widgets/history.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 20, width: double.infinity),
            HeaderSection(),
            FoldersSection(),
            HistorySection(),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

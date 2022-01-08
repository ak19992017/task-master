// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:task_master/widgets/all_tasks_listview.dart';
import 'package:task_master/widgets/logo.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: SingleChildScrollView(
            child: AllTasksListViewSection(header: Logo()),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Center(
            child: Text(
              'Are you on WEB ??? 😎',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ],
    );
  }
}

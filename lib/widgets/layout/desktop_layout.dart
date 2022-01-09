// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:task_master/widgets/all_tasks_listview.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: SingleChildScrollView(
            child: AllTasksListViewSection(
              header: Padding(
                padding: const EdgeInsets.symmetric(vertical: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.favorite, color: Colors.red),
                    Text(
                      "Notion",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
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

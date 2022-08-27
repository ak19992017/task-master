import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/screens/add_screen.dart';

class SuperFAB extends StatelessWidget {
  const SuperFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddTaskScreen(),
          ),
        );
      },
      label: const Text("Add task",
          style: TextStyle(fontSize: 20, color: Colors.white)),
      icon: const Icon(EvaIcons.plus, color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );
  }
}

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/others/constants.dart';

class SuperFAB extends StatelessWidget {
  const SuperFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => addTaskPopup(context),
      label: const Text("Add task",
          style: TextStyle(fontSize: 20, color: Colors.white)),
      icon: const Icon(EvaIcons.plus, color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );
  }
}

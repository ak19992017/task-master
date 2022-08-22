import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/others/constants.dart';
import 'package:task_master/widgets/draawer.dart';

class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTaskPopup(context),
        child: const Icon(EvaIcons.plus, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
      ),
      body: Row(
        children: [
          const SuperDrawer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.grey,
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_master/widgets/draawer.dart';
import 'package:task_master/widgets/ffab.dart';

class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const SuperFAB(),
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

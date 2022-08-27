import 'package:flutter/material.dart';
import 'package:task_master/screens/tasks_page.dart';
import 'package:task_master/widgets/draawer.dart';
import 'package:task_master/widgets/drawer.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          const snackBar = SnackBar(
            elevation: 10,
            content: Text(
              'Press back again to exit',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),

            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(25),
            // backgroundColor: Theme.of(context).primaryColor,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          return true;
        }
      },
      child: const Scaffold(
        drawer: SuperDrawer(),
        body: TasksPage(),
      ),
    );
  }
}

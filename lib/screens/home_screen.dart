import 'package:flutter/material.dart';
import 'package:task_master/screens/chat/chats_page.dart';
import 'package:task_master/screens/task/tasks_page.dart';
import 'package:task_master/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= const Duration(seconds: 2);
          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            final snackBar = SnackBar(
              elevation: 10,
              content: const Text(
                'Press back again to exit',
                style: TextStyle(fontSize: 15, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              shape: const StadiumBorder(),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(25),
              backgroundColor: Theme.of(context).primaryColor,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return false;
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            return true;
          }
        },
        child: Scaffold(
          drawer: const SuperDrawer(),
          body: PageView(
            children: const [
              TasksPage(),
              ChatsPage(),
            ],
          ),
        ),
      ),
    );
  }
}

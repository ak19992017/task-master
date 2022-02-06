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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const SuperDrawer(),
        body: PageView(
          children: const [
            TasksPage(),
            ChatsPage(),
          ],
        ),
      ),
    );
  }
}

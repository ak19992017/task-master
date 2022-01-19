import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/screens/add_screen.dart';
import 'package:task_master/widgets/category.dart';
import 'package:task_master/widgets/drawer.dart';
import 'package:task_master/widgets/header.dart';
import 'package:task_master/widgets/history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: const SuperDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 20, width: double.infinity),
            HeaderSection(),
            CategorySection(),
            HistorySection(),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

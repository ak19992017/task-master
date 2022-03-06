import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/screens/add_screen.dart';
import 'package:task_master/screens/settings_screen.dart';
import 'package:task_master/screens/tasks_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime timeBackPressed = DateTime.now();
  int currentIndex = 0;

  final screens = const [
    TasksPage(),
    Center(child: Text('Feed', style: TextStyle(fontSize: 45))),
    Center(child: Text('Chat', style: TextStyle(fontSize: 45))),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
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
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTaskScreen(),
                ),
              );
            },
            child: const Icon(EvaIcons.plus, color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.homeOutline),
                activeIcon: Icon(EvaIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.heartOutline),
                activeIcon: Icon(EvaIcons.heart),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.messageCircleOutline),
                activeIcon: Icon(EvaIcons.messageCircle),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            iconSize: 25,
            // selectedFontSize: 25,
            // unselectedFontSize: 16,
            showSelectedLabels: true,
            showUnselectedLabels: false,
          ),
        ),
      ),
    );
  }
}

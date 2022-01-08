// ignore_for_file: prefer_const_constructors, unused_import

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:task_master/screens/add_screen.dart';
import 'package:task_master/screens/todo_screen.dart';
import 'package:task_master/widgets/layout/mobile_layout.dart';
import 'package:task_master/widgets/layout/desktop_layout.dart';
import 'package:task_master/widgets/button.dart';
import 'package:task_master/widgets/all_tasks_listview.dart';
import 'package:task_master/widgets/logo.dart';
import 'package:task_master/widgets/layout/responsive_layout.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            // ignore: prefer_const_literals_to_create_immutables
            providerConfigs: [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                clientId: '1:528203664172:android:ea2099fd794708f310fa89',
              ),
            ],
            headerBuilder: (_, __, ____) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset('assets/launch.png'),
              );
            },
            sideBuilder: (_, __) {
              return Image.asset('assets/launch.png');
            },
          );
        }

        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTaskScreen(),
                  ),
                );
              },
              label: const Text("Add task", style: TextStyle(fontSize: 20)),
              icon: const Icon(EvaIcons.plus),
              backgroundColor: Colors.black.withOpacity(0.3),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
            ),
            body: ResponsiveLayout(
              mobileScreenLayout: MobileLayout(),
              desktopScreenLayout: DesktopLayout(),
            ),
          ),
        );
      },
    );
  }
}

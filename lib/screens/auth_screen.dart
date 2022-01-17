// ignore_for_file: prefer_const_constructors, unused_import

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:task_master/screens/add_screen.dart';
import 'package:task_master/screens/todo_screen.dart';
import 'package:task_master/widgets/button.dart';
import 'package:task_master/widgets/history.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: const [
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
            body: ToDoScreen(),
          ),
        );
      },
    );
  }
}

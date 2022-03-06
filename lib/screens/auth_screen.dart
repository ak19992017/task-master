import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:task_master/screens/home_screen.dart';

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
                child: Image.asset('assets/rocket.png'),
              );
            },
            sideBuilder: (_, __) {
              return Image.asset('assets/rocket.png');
            },
          );
        }

        return const SafeArea(
          child: Scaffold(
            body: HomeScreen(),
          ),
        );
      },
    );
  }
}

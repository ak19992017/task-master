import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_master/screens/auth_screen.dart';
import 'package:task_master/widgets/theme_pick.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _signOut() async {
    await _firebaseAuth.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const AuthenticationScreen()),
            (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          const ListTile(title: Text('Themes')),
          const ThemePicker(),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton.icon(
                label: const Text('Log Out', style: TextStyle(fontSize: 20)),
                icon: const Icon(Icons.logout_rounded, size: 25),
                onPressed: _signOut,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

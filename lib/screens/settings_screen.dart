import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_master/others/themes.dart';
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
    var themeProvider = context.watch<ThemeProvider>();
    bool _value =
        themeProvider.selectedThemeMode == ThemeMode.light ? false : true;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          const SizedBox(
            height: 100,
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 50),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: SwitchListTile(
              secondary: _value
                  ? const Icon(EvaIcons.moonOutline)
                  : const Icon(EvaIcons.sunOutline),
              title:
                  _value ? const Text('Dark mode') : const Text('Light mode'),
              value: _value,
              onChanged: (value) {
                setState(() => _value = value);
                _value
                    ? themeProvider.setSelectedThemeMode(ThemeMode.dark)
                    : themeProvider.setSelectedThemeMode(ThemeMode.light);
              },
            ),
          ),
          const Card(
            child: ExpansionTile(
              leading: Icon(EvaIcons.colorPalette),
              title: Text('Themes'),
              children: [ThemePicker()],
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(EvaIcons.starOutline),
              title: Text('Bookmarks'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(EvaIcons.eyeOff2Outline),
              title: Text('Private'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(EvaIcons.trash2Outline),
              title: Text('Trash'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton.icon(
                label: const Text('Log Out', style: TextStyle(fontSize: 18)),
                icon: const Icon(Icons.logout_rounded, size: 22),
                onPressed: _signOut,
                style: ButtonStyle(
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

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_master/others/themes.dart';
import 'package:task_master/screens/settings_screen.dart';

class SuperDrawer extends StatefulWidget {
  const SuperDrawer({Key? key}) : super(key: key);

  @override
  State<SuperDrawer> createState() => _SuperDrawerState();
}

class _SuperDrawerState extends State<SuperDrawer> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    bool _value =
        themeProvider.selectedThemeMode == ThemeMode.light ? false : true;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/rocket.png'),
          const SizedBox(height: 30),
          ListTile(
            leading: _value
                ? const Icon(EvaIcons.moonOutline)
                : const Icon(EvaIcons.sunOutline),
            title: _value ? const Text('Dark mode') : const Text('Light mode'),
            trailing: Switch.adaptive(
              value: _value,
              onChanged: (value) {
                setState(() => _value = value);
                _value
                    ? themeProvider.setSelectedThemeMode(ThemeMode.dark)
                    : themeProvider.setSelectedThemeMode(ThemeMode.light);
              },
            ),
            onTap: () {
              setState(() => _value = !_value);
              _value
                  ? themeProvider.setSelectedThemeMode(ThemeMode.dark)
                  : themeProvider.setSelectedThemeMode(ThemeMode.light);
            },
          ),
          ListTile(
            leading: const Icon(EvaIcons.starOutline),
            title: const Text('Bookmarks'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(EvaIcons.eyeOff2Outline),
            title: const Text('Private'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(EvaIcons.trash2Outline),
            title: const Text('Trash'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
          ),
        ],
      ),
    );
  }
}

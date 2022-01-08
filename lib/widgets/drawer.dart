import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuperDrawer extends StatefulWidget {
  const SuperDrawer({Key? key}) : super(key: key);

  @override
  State<SuperDrawer> createState() => _SuperDrawerState();
}

class _SuperDrawerState extends State<SuperDrawer> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _signOut() async {
    await _firebaseAuth.signOut();
  }

  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 20),
          _firebaseAuth.currentUser!.photoURL == null
              ? const Text("image not found")
              : CircleAvatar(
                  radius: 100,
                  backgroundImage: Image.network(
                    _firebaseAuth.currentUser!.photoURL.toString(),
                    fit: BoxFit.fill,
                  ).image),
          const SizedBox(height: 30),
          ListTile(
            leading: _value
                ? const Icon(EvaIcons.moonOutline)
                : const Icon(EvaIcons.sunOutline),
            title: _value ? const Text('Dark mode') : const Text('Light mode'),
            trailing: Switch(
                value: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                }),
            onTap: () {
              setState(() {
                _value = !_value;
              });
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
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: _signOut,
              child: const Text('LogOut'),
            ),
          )
        ],
      ),
    );
  }
}

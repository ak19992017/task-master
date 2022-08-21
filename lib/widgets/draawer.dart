// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_master/others/constants.dart';
import 'package:task_master/others/firestore_services.dart';
import 'package:task_master/others/themes.dart';
import 'package:task_master/screens/read_screen.dart';
import 'package:task_master/screens/settings_screen.dart';
import 'package:task_master/widgets/folder.dart';
import 'package:task_master/widgets/message.dart';
import 'package:task_master/widgets/task_list_by_date.dart';

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
    String uniqueId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirestoreServices firestoreServices = FirestoreServices();
    return Drawer(
      elevation: 100,
      child: ListView(
        // reverse: true,
        padding: EdgeInsets.zero,
        children: [
          Card(
            child: ListTile(
              leading: _value
                  ? const Icon(EvaIcons.moonOutline)
                  : const Icon(EvaIcons.sunOutline),
              title:
                  _value ? const Text('Dark mode') : const Text('Light mode'),
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
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
              },
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: folderList.length,
            itemBuilder: ((context, index) {
              return Card(
                child: ExpansionTile(
                  title: Text(folderList[index].toString()),
                  leading: const Icon(Icons.folder),
                  // backgroundColor: giveCategoryGetColor(folderList[index]),
                  // collapsedBackgroundColor:
                  // giveCategoryGetColor(folderList[index]),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  textColor: Colors.white,
                  collapsedTextColor: Colors.white,
                  children: [
                    SingleChildScrollView(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: users
                            .doc(uniqueId)
                            .collection('tasks')
                            .where('category',
                                isEqualTo: folderList[index].toLowerCase())
                            .orderBy('createdOn', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: snapshot.data!.docs.map((document) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(
                                      document['task'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        decoration: document['completed']
                                            ? TextDecoration.lineThrough
                                            : null,
                                        decorationThickness: 3,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    tileColor:
                                        giveCategoryGetColor(folderList[index]),
                                    // contentPadding: const EdgeInsets.symmetric(
                                    //     vertical: 10, horizontal: 10),
                                    onTap: () {
                                      showModalBottomSheet(
                                        clipBehavior: Clip.hardEdge,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return DraggableScrollableSheet(
                                            initialChildSize: 0.5,
                                            minChildSize: 0.2,
                                            maxChildSize: 1,
                                            expand: false,
                                            builder: (_, controller) =>
                                                SingleChildScrollView(
                                              controller: controller,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child:
                                                    Message(document: document),
                                              ),
                                            ),
                                          );
                                        },
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50),
                                            topRight: Radius.circular(50),
                                          ),
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      firestoreServices
                                          .toggleCompleted(document);
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator.adaptive());
                          }
                        },
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_master/others/firestore_services.dart';
import 'package:task_master/widgets/message.dart';

class TaskListByDate extends StatefulWidget {
  const TaskListByDate({Key? key}) : super(key: key);

  @override
  _TaskListByDateState createState() => _TaskListByDateState();
}

class _TaskListByDateState extends State<TaskListByDate> {
  @override
  Widget build(BuildContext context) {
    String uniqueId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirestoreServices firestoreServices = FirestoreServices();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        StreamBuilder<QuerySnapshot>(
          stream: users
              .doc(uniqueId)
              .collection('tasks')
              .orderBy('createdOn', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((document) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 12, right: 12),
                    child: ListTile(
                      title: Text(
                        document['task'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          decoration: document['completed']
                              ? TextDecoration.lineThrough
                              : null,
                          decorationThickness: 3,
                        ),
                      ),
                      leading: const Icon(EvaIcons.flash,
                          color: Colors.yellow, size: 35),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tileColor:
                          Color(int.parse(document['color'])).withOpacity(1),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
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
                              builder: (_, controller) => SingleChildScrollView(
                                controller: controller,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Message(document: document),
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
                        firestoreServices.toggleCompleted(document);
                      },
                    ),
                  );
                }).toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        )
      ],
    );
  }
}

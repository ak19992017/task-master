// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/screens/update_screen.dart';
import 'package:task_master/widgets/button.dart';

class PopUpMessage extends StatefulWidget {
  const PopUpMessage({Key? key, required this.document}) : super(key: key);
  final QueryDocumentSnapshot document;
  @override
  State<PopUpMessage> createState() => _PopUpMessageState();
}

class _PopUpMessageState extends State<PopUpMessage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference todos = FirebaseFirestore.instance.collection('todos');
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 1,
      expand: false,
      builder: (_, controller) => SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Icon(EvaIcons.arrowIosUpwardOutline,
                  color: Colors.grey, size: 30),
              Text(
                widget.document['task'],
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                widget.document['description'],
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 40),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  SpecialButton(
                    label: 'Delete',
                    icon: EvaIcons.trash2Outline,
                    onPress: () {
                      todos
                          .doc(widget.document.id)
                          .delete()
                          .then((value) => print("⚡Task Deleted"))
                          .catchError((error) =>
                              print("Failed to delete user: $error"));
                      Navigator.pop(context);
                    },
                    color: Color(int.parse(widget.document['color']))
                        .withOpacity(1),
                  ),
                  SpecialButton(
                    label: 'Edit',
                    icon: EvaIcons.edit2Outline,
                    onPress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UpdateTaskScreen(
                            id: widget.document.id,
                            task: widget.document['task'],
                            desc: widget.document['description'],
                            category: widget.document['category'],
                            completed: widget.document['completed'],
                          );
                        },
                      ),
                    ),
                    color: Color(int.parse(widget.document['color']))
                        .withOpacity(1),
                  ),
                  SpecialButton(
                    label: 'Close',
                    icon: EvaIcons.close,
                    onPress: () => Navigator.pop(context),
                    color: Color(int.parse(widget.document['color']))
                        .withOpacity(1),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

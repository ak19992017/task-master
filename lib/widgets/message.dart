// ignore_for_file: avoid_print, unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_master/screens/update_screen.dart';
import 'package:task_master/others/firestore_services.dart';
import 'package:task_master/widgets/button.dart';

class Message extends StatefulWidget {
  const Message({Key? key, required this.document}) : super(key: key);
  final QueryDocumentSnapshot document;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  bool _locked = false;
  @override
  Widget build(BuildContext context) {
    FirestoreServices firestoreServices = FirestoreServices();
    return Column(
      children: [
        const Icon(EvaIcons.arrowIosUpwardOutline,
            color: Colors.grey, size: 30),
        Text(
          widget.document['task'],
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
        Text(
          DateFormat.yMMMd().add_jm().format(
                DateTime.parse(
                  widget.document['createdOn'].toDate().toString(),
                ),
              ),
        ),
        const SizedBox(height: 15),
        SelectableText(
          widget.document['description'],
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 40),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            SuperButton(
              label: _locked ? 'Unlock' : 'Lock',
              icon: _locked ? EvaIcons.unlockOutline : EvaIcons.lockOutline,
              onPress: () {
                setState(() {
                  _locked = !_locked;
                });
              },
              color: Color(int.parse(widget.document['color'])).withOpacity(1),
            ),
            SuperButton(
              label: 'Close',
              icon: EvaIcons.close,
              onPress: () => Navigator.pop(context),
              color: Color(int.parse(widget.document['color'])).withOpacity(1),
            ),
            if (!_locked)
              SuperButton(
                label: 'Delete',
                icon: EvaIcons.trash2Outline,
                onPress: () {
                  firestoreServices.deleteTask(widget.document.id);
                  Navigator.pop(context);
                },
                color:
                    Color(int.parse(widget.document['color'])).withOpacity(1),
              ),
            if (!_locked)
              SuperButton(
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
                color:
                    Color(int.parse(widget.document['color'])).withOpacity(1),
              ),
          ],
        )
      ],
    );
  }
}

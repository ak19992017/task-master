// ignore_for_file: avoid_print, unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_master/screens/update_screen.dart';
import 'package:task_master/widgets/button.dart';
import 'package:task_master/widgets/message.dart';

class PopUp extends StatefulWidget {
  const PopUp({Key? key, required this.document}) : super(key: key);
  final QueryDocumentSnapshot document;
  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 1,
      expand: false,
      builder: (_, controller) => SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Message(document: widget.document),
        ),
      ),
    );
  }
}

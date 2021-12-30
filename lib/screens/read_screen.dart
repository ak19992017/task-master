import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/widgets/pop_up_msg.dart';

class ReadTaskScreen extends StatefulWidget {
  const ReadTaskScreen({Key? key, required this.color, required this.text})
      : super(key: key);
  final Color color;
  final String text;

  @override
  State<ReadTaskScreen> createState() => _ReadTaskScreenState();
}

class _ReadTaskScreenState extends State<ReadTaskScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference todos = FirebaseFirestore.instance.collection('todos');
    var temp = todos.where('category', isEqualTo: widget.text);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.text),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: temp.snapshots(),
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
                        tileColor: widget.color,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        onTap: () {
                          showModalBottomSheet(
                            clipBehavior: Clip.hardEdge,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) =>
                                PopUpMessage(document: document),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

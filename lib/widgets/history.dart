// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/widgets/pop_up_msg.dart';

class HistorySection extends StatefulWidget {
  const HistorySection({Key? key}) : super(key: key);

  @override
  _HistorySectionState createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  @override
  Widget build(BuildContext context) {
    CollectionReference todos = FirebaseFirestore.instance.collection('todos');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "History",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
        ),
        const SizedBox(height: 15),
        StreamBuilder<QuerySnapshot>(
          stream: todos.snapshots(),
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
                            return PopUpMessage(document: document);
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
                        todos
                            .doc(document.id)
                            .update({'completed': !document['completed']})
                            .then((value) => print("🍄Toggle task state"))
                            .catchError((error) =>
                                print("Failed to update user: $error"));
                      },
                    ),
                  );
                }).toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
      ],
    );
  }
}

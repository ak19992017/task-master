import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_master/models/todo_model.dart';
import 'package:task_master/screens/update_screen.dart';

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
    var todoModel = context.watch<ToDoModel>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.text),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: todoModel.filterListBasedOnCategory(widget.text).length,
            itemBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
              child: ListTile(
                title: Text(
                  todoModel.filterListBasedOnCategory(widget.text)[index].task,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                leading:
                    const Icon(EvaIcons.flash, color: Colors.yellow, size: 35),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: widget.color,
                contentPadding: const EdgeInsets.all(12),
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
                            child: Column(
                              children: [
                                const Icon(
                                  EvaIcons.arrowIosUpwardOutline,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                Text(
                                  todoModel
                                      .filterListBasedOnCategory(
                                          widget.text)[index]
                                      .task,
                                  style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  todoModel
                                      .filterListBasedOnCategory(
                                          widget.text)[index]
                                      .description,
                                  style: const TextStyle(fontSize: 25),
                                ),
                                const SizedBox(height: 40),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    ElevatedButton.icon(
                                      icon: const Icon(EvaIcons.trash2Outline,
                                          size: 30),
                                      onPressed: () {
                                        setState(() {
                                          // here index only goes till filtered list length not the whole list

                                          todoModel.removeToDoByIndex(todoModel
                                              .toDoList
                                              .indexOf(todoModel
                                                  .filterListBasedOnCategory(
                                                      widget.text)[index]));

                                          Navigator.pop(context);
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(todoModel
                                                .filterListBasedOnCategory(
                                                    widget.text)[index]
                                                .color),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                      label: const Text(
                                        "Delete",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      icon: const Icon(EvaIcons.edit2Outline,
                                          size: 30),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateTaskScreen(
                                              task: todoModel
                                                  .filterListBasedOnCategory(
                                                      widget.text)[index]
                                                  .task,
                                              desc: todoModel
                                                  .filterListBasedOnCategory(
                                                      widget.text)[index]
                                                  .description,
                                              e: todoModel
                                                  .filterListBasedOnCategory(
                                                      widget.text)[index]
                                                  .categoryEnum,
                                              index: index,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(todoModel
                                                .filterListBasedOnCategory(
                                                    widget.text)[index]
                                                .color),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                      label: const Text(
                                        "Edit",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      label: const Text(
                                        'Close',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(todoModel
                                                .filterListBasedOnCategory(
                                                    widget.text)[index]
                                                .color),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon:
                                          const Icon(EvaIcons.close, size: 30),
                                    ),
                                  ],
                                )
                              ],
                            ),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

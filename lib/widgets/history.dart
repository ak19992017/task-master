import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_master/models/todo_model.dart';
import 'package:task_master/screens/update_screen.dart';
import 'package:task_master/widgets/button.dart';

class HistorySection extends StatefulWidget {
  const HistorySection({Key? key}) : super(key: key);

  @override
  _HistorySectionState createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  @override
  Widget build(BuildContext context) {
    var todoModel = context.watch<ToDoModel>();
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
        if (todoModel.toDoList.isEmpty)
          FlutterLogo(
            size: MediaQuery.of(context).size.width,
            style: FlutterLogoStyle.stacked,
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: todoModel.toDoList.length,
          itemBuilder: (context, index) {
            var temp = todoModel.toDoList[index];
            return Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
              child: ListTile(
                title: Text(
                  temp.task,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                leading:
                    const Icon(EvaIcons.flash, color: Colors.yellow, size: 35),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: temp.color,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                                  temp.task,
                                  style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  temp.description,
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
                                      onPress: () => setState(() {
                                        todoModel.toDoList.removeAt(index);
                                        Navigator.pop(context);
                                      }),
                                      color: temp.color,
                                    ),
                                    SpecialButton(
                                      label: 'Edit',
                                      icon: EvaIcons.edit2Outline,
                                      onPress: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return UpdateTaskScreen(
                                              task: temp.task,
                                              desc: temp.description,
                                              e: temp.categoryEnum,
                                              index: index,
                                            );
                                          },
                                        ),
                                      ),
                                      color: temp.color,
                                    ),
                                    SpecialButton(
                                      label: 'Close',
                                      icon: EvaIcons.close,
                                      onPress: () => Navigator.pop(context),
                                      color: temp.color,
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
                // onLongPress: () {
                // showModalBottomSheet(
                //   isScrollControlled: true,
                //   context: context,
                //   builder: (context) {
                //     return DraggableScrollableSheet(
                //       initialChildSize: 0.5,
                //       minChildSize: 0.2,
                //       maxChildSize: 0.8,
                //       expand: false,
                //       builder: (_, controller) => Column(
                //         children: [
                //           const Icon(
                //             EvaIcons.arrowIosUpwardOutline,
                //             color: Colors.white,
                //             size: 30,
                //           ),
                //           Expanded(
                //             child: ListView.builder(
                //               controller: controller,
                //               itemCount:
                //                   toDoModel.toDoList.length,
                //               itemBuilder: (_, index) {
                //                 return Padding(
                //                   padding:
                //                       const EdgeInsets.only(
                //                           top: 5,
                //                           bottom: 5,
                //                           left: 8,
                //                           right: 8),
                //                   child: ListTile(
                //                     title: Text(
                //                       toDoModel
                //                           .toDoList[index]
                //                           .task,
                //                       style: const TextStyle(
                //                           color: Colors.white,
                //                           fontSize: 20),
                //                     ),
                //                     leading: const Icon(
                //                         EvaIcons.bulb,
                //                         color: Colors.yellow,
                //                         size: 35),
                //                     trailing: const Icon(
                //                         EvaIcons
                //                             .trash2Outline,
                //                         color: Colors.white),
                //                     shape:
                //                         RoundedRectangleBorder(
                //                             borderRadius:
                //                                 BorderRadius
                //                                     .circular(
                //                                         20)),
                //                     tileColor:
                //                         colorsList[index % 4],
                //                   ),
                //                 );
                //               },
                //             ),
                //           ),
                //           ElevatedButton(
                //             child: const Text(
                //                 'Close Model BottomSheet'),
                //             onPressed: () =>
                //                 Navigator.pop(context),
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                //   shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(50),
                //       topRight: Radius.circular(50),
                //     ),
                //   ),
                //   backgroundColor: Colors.transparent,
                // );
                // },
              ),
            );
          },
        ),
      ],
    );
  }
}

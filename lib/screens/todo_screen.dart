import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/models/todo_model.dart';
import 'package:provider/provider.dart';
import 'package:task_master/screens/add_screen.dart';
import 'package:task_master/screens/update_screen.dart';
import 'package:task_master/widgets/carousal.dart';
import 'package:task_master/widgets/category.dart';
import 'package:task_master/widgets/custom_page_route.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  String userName = "Aditya Kumar";
  bool isEditable = false;
  @override
  Widget build(context) {
    var toDoModel = context.watch<ToDoModel>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            CustomPageRoute(
                child: const AddTaskScreen(), direction: AxisDirection.up),
          );
        },
        label: const Text(
          "Add task",
          style: TextStyle(fontSize: 20),
        ),
        icon: const Icon(EvaIcons.plus),
        backgroundColor: Colors.black.withOpacity(0.4),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text("Hello,",
                      style: TextStyle(fontSize: 25, color: Colors.black54)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: !isEditable
                            ? Text(userName,
                                style: const TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold))
                            : TextFormField(
                                style: const TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                ),
                                autofocus: true,
                                initialValue: userName,
                                textInputAction: TextInputAction.done,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.name,
                                onFieldSubmitted: (value) => setState(
                                  () => {isEditable = false, userName = value},
                                ),
                              ),
                      ),
                      IconButton(
                        icon: const Icon(EvaIcons.editOutline, size: 22),
                        onPressed: () =>
                            setState(() => {isEditable = true, userName = ""}),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const CategorySection(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: toDoModel.toDoList.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "History",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 12, right: 12),
                        child: ListTile(
                          title: Text(
                            toDoModel.toDoList[index].task,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          leading: const Icon(EvaIcons.flash,
                              color: Colors.yellow, size: 35),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          tileColor: toDoModel.toDoList[index].color,
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
                                  builder: (_, controller) =>
                                      SingleChildScrollView(
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
                                            toDoModel.toDoList[index].task,
                                            style: const TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            toDoModel
                                                .toDoList[index].description,
                                            style:
                                                const TextStyle(fontSize: 25),
                                          ),
                                          const SizedBox(height: 40),
                                          Wrap(
                                            alignment: WrapAlignment.center,
                                            spacing: 10,
                                            runSpacing: 10,
                                            children: [
                                              ElevatedButton.icon(
                                                icon: const Icon(
                                                    EvaIcons.trash2Outline,
                                                    size: 30),
                                                onPressed: () {
                                                  setState(() {
                                                    toDoModel.toDoList
                                                        .removeAt(index);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          toDoModel
                                                              .toDoList[index]
                                                              .color),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                    const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 12,
                                                    ),
                                                  ),
                                                ),
                                                label: const Text(
                                                  "Delete",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                              ),
                                              ElevatedButton.icon(
                                                icon: const Icon(
                                                    EvaIcons.edit2Outline,
                                                    size: 30),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateTaskScreen(
                                                        task: toDoModel
                                                            .toDoList[index]
                                                            .task,
                                                        desc: toDoModel
                                                            .toDoList[index]
                                                            .description,
                                                        e: toDoModel
                                                            .toDoList[index]
                                                            .categoryEnum,
                                                        index: index,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          toDoModel
                                                              .toDoList[index]
                                                              .color),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                    const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 12,
                                                    ),
                                                  ),
                                                ),
                                                label: const Text(
                                                  "Edit",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                              ),
                                              ElevatedButton.icon(
                                                label: const Text(
                                                  'Close',
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          toDoModel
                                                              .toDoList[index]
                                                              .color),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                    const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 12,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(EvaIcons.close,
                                                    size: 30),
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
                      ),
                    ],
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 12, right: 12),
                  child: ListTile(
                    title: Text(
                      toDoModel.toDoList[index].task,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    leading: const Icon(EvaIcons.flash,
                        color: Colors.yellow, size: 35),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    tileColor: toDoModel.toDoList[index].color,
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
                                      toDoModel.toDoList[index].task,
                                      style: const TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      toDoModel.toDoList[index].description,
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                    const SizedBox(height: 40),
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        ElevatedButton.icon(
                                          icon: const Icon(
                                              EvaIcons.trash2Outline,
                                              size: 30),
                                          onPressed: () {
                                            setState(() {
                                              toDoModel.toDoList
                                                  .removeAt(index);
                                              Navigator.pop(context);
                                            });
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    toDoModel
                                                        .toDoList[index].color),
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
                                          icon: const Icon(
                                              EvaIcons.edit2Outline,
                                              size: 30),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateTaskScreen(
                                                  task: toDoModel
                                                      .toDoList[index].task,
                                                  desc: toDoModel
                                                      .toDoList[index]
                                                      .description,
                                                  e: toDoModel.toDoList[index]
                                                      .categoryEnum,
                                                  index: index,
                                                ),
                                              ),
                                            );
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    toDoModel
                                                        .toDoList[index].color),
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
                                                MaterialStateProperty.all(
                                                    toDoModel
                                                        .toDoList[index].color),
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
                                          icon: const Icon(EvaIcons.close,
                                              size: 30),
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
            const Carousal(),
            const SizedBox(height: 300, child: Placeholder()),
          ],
        ),
      ),
    );
  }
}

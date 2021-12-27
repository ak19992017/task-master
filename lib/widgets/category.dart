import 'package:flutter/material.dart';
import 'package:task_master/models/todo_model.dart';
import 'package:task_master/screens/read_screen.dart';
import 'package:task_master/widgets/custom_page_route.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width + 30,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categoryList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  CustomPageRoute(
                    child: ReadTaskScreen(
                      color: colorsList[index],
                      text: categoryList[index],
                    ),
                    // direction:dirList[index],
                    direction: AxisDirection.left,
                  ),
                ),
                // onTap: () {
                //   showModalBottomSheet(
                //     isScrollControlled: true,
                //     context: context,
                //     builder: (context) {
                //       return DraggableScrollableSheet(
                //         initialChildSize: 0.5,
                //         minChildSize: 0.2,
                //         maxChildSize: 0.8,
                //         expand: false,
                //         builder: (_, controller) => Column(
                //           children: [
                //             Icon(
                //               EvaIcons.arrowIosUpwardOutline,
                //               color: Colors.white,
                //               size: 30,
                //             ),
                //             Expanded(
                //               child: ListView.builder(
                //                 controller: controller,
                //                 itemCount: toDoModel.toDoList.length,
                //                 itemBuilder: (_, index) {
                //                   return Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 5, bottom: 5, left: 8, right: 8),
                //                     child: ListTile(
                //                       title: Text(
                //                         toDoModel.toDoList[index].task,
                //                         style: TextStyle(
                //                             color: Colors.white, fontSize: 20),
                //                       ),
                //                       leading: Icon(EvaIcons.bulb,
                //                           color: Colors.yellow, size: 35),
                //                       trailing: Icon(EvaIcons.trash2Outline,
                //                           color: Colors.white),
                //                       shape: RoundedRectangleBorder(
                //                           borderRadius:
                //                               BorderRadius.circular(20)),
                //                       tileColor: colorsList[index % 4],
                //                     ),
                //                   );
                //                 },
                //               ),
                //             ),
                //             ElevatedButton(
                //               child: Text('Close Model BottomSheet'),
                //               onPressed: () => Navigator.pop(context),
                //             ),
                //           ],
                //         ),
                //       );
                //     },
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(50),
                //         topRight: Radius.circular(50),
                //       ),
                //     ),
                //     backgroundColor: Colors.transparent,
                //   );
                // },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorsList[index],
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: colorsList[index].withOpacity(0.5),
                        offset: const Offset(10, 10),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Center(
                      child: Text(
                    categoryList[index],
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  )),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

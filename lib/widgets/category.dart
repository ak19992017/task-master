import 'package:flutter/material.dart';
import 'package:task_master/models/todo_model.dart';
import 'package:task_master/screens/read_screen.dart';
import 'package:task_master/widgets/page_route.dart';

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
                    direction: AxisDirection.left,
                  ),
                ),
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
                        blurRadius: 2,
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

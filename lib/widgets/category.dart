import 'package:flutter/material.dart';
import 'package:task_master/constants.dart';
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
                      color: giveCategoryGetColor(categoryList[index]),
                      text: categoryList[index],
                    ),
                    direction: AxisDirection.left,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: giveCategoryGetColor(categoryList[index]),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: giveCategoryGetColor(categoryList[index])
                            .withOpacity(0.5),
                        offset: const Offset(10, 10),
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Center(
                      child: Text(
                    categoryList[index].toUpperCase(),
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

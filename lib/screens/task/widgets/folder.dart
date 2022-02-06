// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:task_master/others/constants.dart';
import 'package:task_master/screens/task/read_screen.dart';

class FoldersSection extends StatefulWidget {
  const FoldersSection({Key? key}) : super(key: key);

  @override
  State<FoldersSection> createState() => _FoldersSectionState();
}

class _FoldersSectionState extends State<FoldersSection> {
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
                  MaterialPageRoute(
                    builder: (context) =>
                        ReadTaskScreen(text: categoryList[index]),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: giveCategoryGetColor(categoryList[index]),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: giveCategoryGetColor(categoryList[index])
                    //         .withOpacity(0.5),
                    //     offset: const Offset(10, 10),
                    //     blurRadius: 2,
                    //   )
                    // ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/' + imageList[index]),
                      Text(
                        categoryList[index].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

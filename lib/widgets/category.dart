// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:task_master/constants.dart';
import 'package:task_master/screens/read_screen.dart';
import 'package:task_master/widgets/page_route.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>> getIconListString() async {
    ListResult result = await storage.ref('icons').listAll();
    List<Reference> r = result.items;
    List<String> list = [];
    for (int i = 0; i < r.length; i++) {
      String s = await storage.ref(r[i].fullPath).getDownloadURL();
      list.add(s);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    getIconListString();
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
                      FutureBuilder<List<String>>(
                        future: getIconListString(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            print("snaphot dat lenght =>" +
                                snapshot.data!.length.toString());
                            return Image.network(
                                snapshot.data!.elementAt(index));
                          }
                          if (snapshot.hasError) {
                            print('🔴🔴🔴🔴 ERROR 🔴🔴🔴🔴');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return Text(snapshot.data.toString());
                        },
                      ),
                      Center(
                        child: Text(
                          categoryList[index].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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

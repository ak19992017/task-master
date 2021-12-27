import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_master/models/todo_model.dart';
import 'package:task_master/screens/todo_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ToDoModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //bouncy effect throughout app
      scrollBehavior: const ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      theme: ThemeData(
        
        primarySwatch: Colors.red,
        fontFamily: "Poppins",
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          height: 35,
          padding: const EdgeInsets.all(10.0),
          textStyle: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      home: const SafeArea(
        child: Scaffold(
          body: ToDoScreen(),
        ),
      ),
    );
  }
}

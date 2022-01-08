import 'package:flutter/material.dart';
import 'package:task_master/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
          inputDecorationTheme: InputDecorationTheme(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.redAccent),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
        ),
        home: const AuthenticationScreen());
  }
}

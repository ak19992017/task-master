import 'package:flutter/material.dart';
import 'package:task_master/others/firestore_services.dart';

Color giveCategoryGetColor(String e) {
  if (e == 'Home') {
    return Colors.redAccent;
  } else if (e == 'Work') {
    return Colors.greenAccent.shade700;
  } else if (e == 'Code') {
    return Colors.blueAccent;
  } else if (e == 'Play') {
    return Colors.amberAccent.shade700;
  }
  return Colors.grey;
}

List<String> folderList = ["Home", "Work", "Code", "Play"];

List<String> imageList = [
  'pencil.png',
  'travel.png',
  'takeaway-cup.png',
  'rocket.png'
];

// PrimaryColor is of type Color
// PrimarySwatch only accepts a MaterialColor.
// We’ll create a cool function that will get a MaterialColor from a Color.
// MaterialColor is a color with a primary value (first param; int),
// and 10 shades of that color (second param; Map<int, Color>) with the int map key as the shade index

// (Important)Shade with index 500 is the primary color of that material color.
// So we needed to find a way to get darker and lighter shades of a certain color to create all the shades.

class AppColors {
  static List<Color> primaryColors = const [
    Color(0xffff5252),
    Color(0xff00c853),
    Color(0xff448aff),
    Color(0xffffab00),
  ];

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> _colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color,
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, _colorShades);
  }
}

addTaskPopup(BuildContext context) {
  final TextEditingController _task = TextEditingController();
  final TextEditingController _description = TextEditingController();
  String _dropdownValue = 'Home';
  bool _completed = false;
  FirestoreServices firestoreServices = FirestoreServices();
  //Create AlertDialog and show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Add a task to your list'),
          content: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 24.0),
                      // const Text('Task',
                      //     style: TextStyle(fontWeight: FontWeight.bold)),
                      // const SizedBox(height: 8.0),
                      TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter task here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                        controller: _task,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      // const SizedBox(height: 30.0),
                      // const Text(
                      //   'Description',
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter description here',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                        controller: _description,
                        maxLines: 6,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                  DropdownButton<String>(
                    value: _dropdownValue,
                    items: folderList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          child: Text(value), value: value);
                    }).toList(),
                    onChanged: (String? newValue) =>
                        setState(() => _dropdownValue = newValue!),
                  ),
                  Switch(
                    value: _completed,
                    onChanged: (value) => setState(() => _completed = value),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text(
                        'ADD TASK',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              giveCategoryGetColor(_dropdownValue)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 8))),
                      onPressed: () {
                        firestoreServices.addTask(_task.text, _description.text,
                            _completed, _dropdownValue);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          // actions: <Widget>[
          //   ElevatedButton(
          //     child: const Text('ADD'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          //   TextButton(
          //     child: const Text('CANCEL'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      });
    },
  );
}

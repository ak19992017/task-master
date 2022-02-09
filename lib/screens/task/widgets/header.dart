import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  String userName = "Aditya";
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Hello,",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              // color: Colors.black87,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: !isEditable
                    ? Text(userName,
                        style: const TextStyle(
                            fontSize: 52, fontWeight: FontWeight.bold))
                    : TextFormField(
                        style: const TextStyle(
                            fontSize: 52, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                        ),
                        autofocus: true,
                        initialValue: userName,
                        textInputAction: TextInputAction.done,
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
    );
  }
}

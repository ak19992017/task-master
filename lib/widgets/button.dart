import 'package:flutter/material.dart';

class SpecialButton extends StatefulWidget {
  const SpecialButton(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onPress,
      required this.color})
      : super(key: key);
  final String label;
  final IconData icon;
  final Function()? onPress;
  final Color color;
  @override
  State<SpecialButton> createState() => _SpecialButtonState();
}

class _SpecialButtonState extends State<SpecialButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(widget.label, style: const TextStyle(fontSize: 25)),
      icon: Icon(widget.icon, size: 30),
      onPressed: widget.onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(widget.color),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
        ),
      ),
    );
  }
}

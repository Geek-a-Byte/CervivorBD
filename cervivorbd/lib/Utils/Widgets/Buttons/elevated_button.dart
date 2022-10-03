import 'package:flutter/material.dart';

class ElevatedButton2 extends StatelessWidget {
  final String? label;
  final GestureTapCallback? onPressed;
  final Color? color;
  final IconData? icon;
  // ignore: use_key_in_widget_constructors
  const ElevatedButton2(
      {@required this.onPressed, this.label, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: color,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8)),
          icon: Icon(icon),
          label: Text(
            label!,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          )),
    );
  }
}

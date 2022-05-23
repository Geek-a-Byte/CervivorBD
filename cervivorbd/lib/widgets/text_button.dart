import 'package:flutter/material.dart';

class TextButton2 extends StatelessWidget {
  final String? label;
  final GestureTapCallback? onPressed;

  const TextButton2({@required this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        label!,
        style: const TextStyle(color: Color.fromARGB(255, 35, 118, 220)),
      ),
      onPressed: onPressed,
    );
  }
}

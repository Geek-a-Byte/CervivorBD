import 'package:flutter/material.dart';

class ElevatedButton2 extends StatelessWidget {
  final String? label;
  final GestureTapCallback? onPressed;

  const ElevatedButton2({@required this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 184, 0, 98),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            textStyle:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        child: Text(
          label!,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ));
  }
}

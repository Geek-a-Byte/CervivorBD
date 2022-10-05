import 'package:flutter/material.dart';

class TextButton2 extends StatelessWidget {
  final String? label;
  final GestureTapCallback? onPressed;

  // ignore: use_key_in_widget_constructors
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

class TextButton3 extends StatelessWidget {
  final String? label;
  final GestureTapCallback? onPressed;

  // ignore: use_key_in_widget_constructors
  const TextButton3({@required this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(50, 30),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft),
      child: Text(
        label!,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}

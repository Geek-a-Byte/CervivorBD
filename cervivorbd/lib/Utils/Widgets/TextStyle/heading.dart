import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Heading extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  Heading({Key? key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label!,
      textAlign: TextAlign.left,
      // "ফ্রিতে নিবন্ধন করুন",
      style: const TextStyle(
        fontFamily: 'Lato',
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

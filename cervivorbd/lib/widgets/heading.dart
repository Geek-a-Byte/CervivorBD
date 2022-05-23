import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  Heading({Key? key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
        label!,
        // "ফ্রিতে নিবন্ধন করুন",
        style: const TextStyle(
          fontFamily: 'Hind Siliguri Bold',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

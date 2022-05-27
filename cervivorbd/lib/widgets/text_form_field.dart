import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormField2 extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  TextFormField2({Key? key, this.controller,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.015,
        bottom: MediaQuery.of(context).size.height * 0.015,
      ),
      child: TextField(
        style: const TextStyle(
          fontFamily: 'Hind Siliguri Regular',
        ),
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: label,
          // hintText: 'Email',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 219, 76, 169), width: 0.5),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 219, 76, 169), width: 0.5),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        onChanged: (value) {
          // do something
        },
      ),
    );
  }
}

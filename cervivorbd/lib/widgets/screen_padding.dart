import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenPadding extends StatelessWidget {
  TextEditingController? controller;
  num? top, bottom, left, right;
  ScreenPadding({Key? key, this.top, this.bottom, this.left, this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
      left: MediaQuery.of(context).size.height * left!,
      top: MediaQuery.of(context).size.height * top!,
      bottom: MediaQuery.of(context).size.height * bottom!,
      right: MediaQuery.of(context).size.height * right!,
    ));
  }
}

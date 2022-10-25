// ignore_for_file: must_be_immutable

import 'package:cervivorbd/Utils/Theme/color_constants.dart';
import 'package:flutter/material.dart';

class Appbar4 extends StatelessWidget with PreferredSizeWidget {
  String? label;
  Appbar4({Key? key, required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: false,
      title: Transform(
        // you can forcefully translate values left side using Transform
        transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
        child: Text(
          label!,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: kBlackColor900),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

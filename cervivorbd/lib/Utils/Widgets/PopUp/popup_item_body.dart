// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PopUpItemBody extends StatelessWidget {
  String? intro;
  PopUpItemBody({Key? key, required this.intro}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            intro!,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

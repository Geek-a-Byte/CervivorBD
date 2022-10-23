// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PopUpItemBody extends StatelessWidget {
  const PopUpItemBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'hello',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

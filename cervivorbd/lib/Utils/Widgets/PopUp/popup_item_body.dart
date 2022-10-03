import 'package:flutter/material.dart';

class PopUpItemBody extends StatelessWidget {
  String? intro;
  PopUpItemBody({required this.intro});
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

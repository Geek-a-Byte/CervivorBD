import 'package:flutter/material.dart';

class PopUpItemBody extends StatelessWidget {
  const PopUpItemBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'বাংলাদেশে স্ক্রিনিং সেন্টারগুলো সম্পর্কে জানুন',
            style: Theme.of(context).textTheme.headline4,
          ),
          const Text('hellooo'),
        ],
      ),
    );
  }
}

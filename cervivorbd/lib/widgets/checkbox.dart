import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  final String label;
  final bool value;
  final Function onChanged;

  const CheckBoxWidget({
    required this.label,
    required this.value,
    required this.onChanged,
  });



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue);
              },
            ),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }
}

import 'package:cervivorbd/widgets/intro_button.dart';
import 'package:flutter/material.dart';

class CCIntroGridMenu extends StatelessWidget {
  const CCIntroGridMenu({Key? key}) : super(key: key);

  @override
 Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 2,
      ),
      padding: EdgeInsets.zero,
      itemCount: introMenu.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 81,
            ),
            child: Column(
              children: [
                
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 56,
                    minWidth: 56,
                    maxHeight: 69,
                    maxWidth: 69,
                  ),
                child: IntroButton2(
                    label: introMenu[index].label!,
                    onPressed:(){}),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
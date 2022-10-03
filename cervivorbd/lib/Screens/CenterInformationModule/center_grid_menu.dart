
import 'package:cervivorbd/Utils/Widgets/Buttons/intro_button.dart';
import 'package:flutter/material.dart';

class CenterGridMenu extends StatelessWidget {
  const CenterGridMenu({Key? key}) : super(key: key);

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
      itemCount: centerMenu.length,
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
                    minHeight: 55,
                    minWidth: 55,
                    maxHeight: 72,
                    maxWidth: 72,
                  ),
                  child: IntroButton3(
                      label: centerMenu[index].label!, onPressed: () {}),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

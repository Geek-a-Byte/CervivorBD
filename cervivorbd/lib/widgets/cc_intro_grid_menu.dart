import 'package:cervivorbd/color_constants.dart';
import 'package:cervivorbd/models/introduction_to_cervical_cancer.dart';
import 'package:cervivorbd/widgets/intro_button.dart';
import 'package:cervivorbd/widgets/popup_item_body.dart';
import 'package:cervivorbd/widgets/popup_item_launcher.dart';
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
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      padding: EdgeInsets.zero,
      itemCount: introMenu.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          child: PopupItemLauncher(
            tag: 'test' + index.toString(),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: kdarkPink,
                  border: Border.all(
                    color: kPink,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(introMenu[index].label!,
                        style: const TextStyle(
                            fontSize: 10, color: kWhiteColor)),
                  ),
                ),
              ),
            ),
            popUp: PopUpItem(
              padding: const EdgeInsets.all(8), // Padding inside of the card
              color: Colors.white, // Color of the card
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)), // Shape of the card
              elevation: 2, // Elevation of the card
              tag: 'test', // MUST BE THE SAME AS IN `PopupItemLauncher`
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopUpItemBody(intro:introCCMenu[index]),
              ), // Your custom child widget.
            ),
          ),
          // Container(
          //   constraints: const BoxConstraints(
          //     maxHeight: 81,
          //   ),
          //   child: Column(
          //     children: [

          //       Container(
          //         constraints: const BoxConstraints(
          //           minHeight: 56,
          //           minWidth: 56,
          //           maxHeight: 69,
          //           maxWidth: 69,
          //         ),
          //       child: IntroButton2(
          //           label: introMenu[index].label!,
          //           onPressed:(){}),
          //       )
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}

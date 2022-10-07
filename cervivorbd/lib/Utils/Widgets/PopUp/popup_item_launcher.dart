// NOTE: Most of the credit for this code goes to 'funwithflutter' on GitHub
// ignore_for_file: implementation_imports

library popup_card;

import 'package:flutter/material.dart';
import 'package:popup_card/src/hero_route.dart';

// [PopupItemLauncher], when wrapped around a widget like an [Icon], launches the [PopUpItem] widget.
class PopupItemLauncher extends StatelessWidget {
  final Object? tag;
  final Widget? child;
  final Widget? popUp;
  const PopupItemLauncher({Key? key, this.tag, this.child, this.popUp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return popUp!;
          }));
        },
        child: Hero(
          tag: tag!,
          child: child!,
        ),
      ),
    );
  }
}

// This is the actual pop up card. You provide this to [PopUpItemLauncher].
class PopUpItem extends StatelessWidget {
  final Object tag;
  final Widget child;
  final Color color;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final ShapeBorder shape;
  const PopUpItem({
    Key? key,
    required this.tag,
    required this.child,
    required this.color,
    required this.padding,
    required this.shape,
    this.elevation = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Hero(
          tag: tag,
          child: Material(
            color: color,
            elevation: elevation,
            shape: shape,
            child: SingleChildScrollView(
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

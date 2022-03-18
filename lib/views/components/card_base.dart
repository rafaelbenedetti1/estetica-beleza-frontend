import 'package:flutter/material.dart';

class CardBase extends StatelessWidget {
  final Widget? child;
  final double? heigth;
  final double? width;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? backgroundColor;
  final Function? onTapCard;

  CardBase(
      {this.child,
      this.heigth,
      this.width,
      this.horizontalPadding,
      this.verticalPadding,
      this.backgroundColor,
      this.onTapCard});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 12, vertical: verticalPadding ?? 12),
      // The Align ideal here, it`s because every view needs a x and y point to draw his heigth and width
      // Otherwise will not respect these params
      child: Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: backgroundColor ?? Theme.of(context).cardColor,
            elevation: 10,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  height: heigth,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: child),
            ),
          )),
    );
  }
}

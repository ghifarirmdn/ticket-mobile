import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color bgColor;
  final Color borderColor;
  final double verticalPadding;
  final double? horizontalPadding;
  final double? imageSize;
  final void Function()? onTap;
  final Widget? child;

  const ButtonWidget({
    super.key,
    required this.bgColor,
    required this.borderColor,
    this.imageSize,
    this.onTap,
    this.verticalPadding = 10.0,
    this.horizontalPadding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    double horizontalBodyPadding = 0;
    if (horizontalPadding == null) {
      horizontalBodyPadding = 15;
    } else {
      horizontalBodyPadding = horizontalPadding!;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalBodyPadding,
          vertical: verticalPadding,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

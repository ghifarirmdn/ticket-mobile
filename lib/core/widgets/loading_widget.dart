import 'package:flutter/material.dart';
import 'package:ticket_mobile/core/constants/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(
        color: color ?? secondaryColor,
        strokeWidth: 2,
      ),
    );
  }
}

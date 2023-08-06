

import 'package:flutter/material.dart';
import 'package:tudushka/src/theme/app_colors.dart';

class TalkerBaseCardW extends StatelessWidget {
  const TalkerBaseCardW({
    Key? key,
    required this.child,
    required this.color,
    this.padding = const EdgeInsets.all(8),
    this.margin,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: padding,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.highlightColor,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

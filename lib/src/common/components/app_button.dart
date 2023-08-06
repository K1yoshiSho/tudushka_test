import 'package:flutter/material.dart';
import 'package:tudushka/src/theme/app_colors.dart';

/// `AppButton` is a custom button widget.
class AppButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final bool? isOutline;
  final bool? isDisabled;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final int? fontSize;
  final Widget? iconRight;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.isOutline,
    this.isDisabled,
    this.fontWeight,
    this.height,
    this.width,
    this.fontSize,
    this.iconRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        height: height ?? 50,
        width: width ?? MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: isDisabled == true
              ? AppColors.primaryColor.withOpacity(0.5)
              : isOutline == true
                  ? AppColors.accent100
                  : buttonColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          splashColor: AppColors.splashColor,
          highlightColor: AppColors.splashColorMButton,
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isOutline == true ? textColor ?? AppColors.primaryColor : textColor ?? Colors.white,
                  fontSize: fontSize?.toDouble() ?? 14,
                  fontWeight: fontWeight ?? FontWeight.w500,
                ),
              ),
              iconRight ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tudushka/src/theme/app_colors.dart';

/// `AppStyles` - This class contains all app styles (without `TextStyle`).
final class AppStyles {
  static List<BoxShadow> getBoxShadow() {
    return [
      BoxShadow(
        color: AppColors.abyssColor.withOpacity(0.05),
        blurRadius: 1,
        spreadRadius: 1,
      )
    ];
  }

  static final ButtonStyle iconButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0.0)),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    splashFactory: NoSplash.splashFactory,
    overlayColor: MaterialStateProperty.all<Color>(AppColors.splashColor),
    shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
  );
}

/// `AppTextStyle` - This class contains all app text styles.
class AppTextStyle {
  // -------------------------------------------------- Custom - Label --------------------------------------------------

  static TextStyle _generateTextStyle(BuildContext context, double fontSize, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: "Inter",
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: AppColors.abyssColor,
    );
  }

// Small labels
  static TextStyle labelSmall400(BuildContext context) => _generateTextStyle(context, 11, FontWeight.w400);
  static TextStyle labelSmall500(BuildContext context) => _generateTextStyle(context, 11, FontWeight.w500);
  static TextStyle labelSmall600(BuildContext context) => _generateTextStyle(context, 11, FontWeight.w600);
  static TextStyle labelSmall700(BuildContext context) => _generateTextStyle(context, 11, FontWeight.w700);

// Medium labels
  static TextStyle labelMedium400(BuildContext context) => _generateTextStyle(context, 12, FontWeight.w400);
  static TextStyle labelMedium500(BuildContext context) => _generateTextStyle(context, 12, FontWeight.w500);
  static TextStyle labelMedium600(BuildContext context) => _generateTextStyle(context, 12, FontWeight.w600);
  static TextStyle labelMedium700(BuildContext context) => _generateTextStyle(context, 12, FontWeight.w700);

// Large labels
  static TextStyle labelLarge400(BuildContext context) => _generateTextStyle(context, 13, FontWeight.w400);
  static TextStyle labelLarge500(BuildContext context) => _generateTextStyle(context, 13, FontWeight.w500);
  static TextStyle labelLarge600(BuildContext context) => _generateTextStyle(context, 13, FontWeight.w600);
  static TextStyle labelLarge700(BuildContext context) => _generateTextStyle(context, 13, FontWeight.w700);

// Custom - Body
  static TextStyle bodyMedium400(BuildContext context) => _generateTextStyle(context, 14, FontWeight.w400);
  static TextStyle bodyMedium500(BuildContext context) => _generateTextStyle(context, 14, FontWeight.w500);
  static TextStyle bodyMedium600(BuildContext context) => _generateTextStyle(context, 14, FontWeight.w600);
  static TextStyle bodyMedium700(BuildContext context) => _generateTextStyle(context, 14, FontWeight.w700);

// Custom - Title
  static TextStyle titleSmall400(BuildContext context) => _generateTextStyle(context, 16, FontWeight.w400);
  static TextStyle titleSmall500(BuildContext context) => _generateTextStyle(context, 16, FontWeight.w500);
  static TextStyle titleSmall600(BuildContext context) => _generateTextStyle(context, 16, FontWeight.w600);
  static TextStyle titleSmall700(BuildContext context) => _generateTextStyle(context, 16, FontWeight.w700);

  static TextStyle titleMedium400(BuildContext context) => _generateTextStyle(context, 18, FontWeight.w400);
  static TextStyle titleMedium500(BuildContext context) => _generateTextStyle(context, 18, FontWeight.w500);
  static TextStyle titleMedium600(BuildContext context) => _generateTextStyle(context, 18, FontWeight.w600);
  static TextStyle titleMedium700(BuildContext context) => _generateTextStyle(context, 18, FontWeight.w700);

  static TextStyle titleLarge400(BuildContext context) => _generateTextStyle(context, 20, FontWeight.w400);
  static TextStyle titleLarge500(BuildContext context) => _generateTextStyle(context, 20, FontWeight.w500);
  static TextStyle titleLarge600(BuildContext context) => _generateTextStyle(context, 20, FontWeight.w600);
  static TextStyle titleLarge700(BuildContext context) => _generateTextStyle(context, 20, FontWeight.w700);
}

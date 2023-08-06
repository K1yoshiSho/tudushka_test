// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tudushka/src/theme/app_colors.dart';

/// `AppTheme` - This class contains app themes: light and dark.
/// `LightTheme` - This is light theme of the application.
final ThemeData LightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  splashColor: AppColors.splashColor,
  dividerColor: AppColors.gray200,
  dividerTheme: const DividerThemeData(
    color: AppColors.gray100,
    thickness: 1,
    space: 0,
  ),
  splashFactory: NoSplash.splashFactory,
  highlightColor: AppColors.splashColor,
  primaryColor: AppColors.primaryColor,
  unselectedWidgetColor: AppColors.gray300,
  primaryColorLight: AppColors.gray200,
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0.0)),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.all<Color>(AppColors.splashColor),
      shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
    ),
  ),
  listTileTheme: ListTileThemeData(
    selectedColor: Colors.white,
    selectedTileColor: AppColors.accent100,
    horizontalTitleGap: 5,
    tileColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.gray100,
    showDragHandle: false,
    modalBackgroundColor: Colors.white,
    modalElevation: 0,
    elevation: 0,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  iconTheme: const IconThemeData(color: AppColors.abyssColor, size: 20),
  textTheme: const TextTheme(
    labelLarge: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Color.fromARGB(255, 120, 128, 134),
    ),
    labelMedium: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Color.fromARGB(255, 120, 128, 134),
    ),
    labelSmall: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w400,
      fontSize: 10,
      color: Color.fromARGB(255, 120, 128, 134),
    ),
    titleLarge: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: AppColors.abyssColor,
    ),
    titleMedium: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: AppColors.abyssColor,
    ),
    titleSmall: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: AppColors.abyssColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.abyssColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.abyssColor,
    ),
    bodySmall: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: AppColors.abyssColor,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 20,
    ),
    filled: true,
    fillColor: Colors.white,
    focusColor: Colors.white,
    hoverColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.gray200,
        width: 1.5,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.gray300,
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
        width: 1.5,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.gray200,
        width: 1.5,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.dangerColor,
        width: 1.5,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.dangerColor,
        width: 1.5,
      ),
    ),
    labelStyle: const TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.abyssColor,
    ),
    hintStyle: const TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.grayText,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    splashColor: AppColors.splashColor,
    highlightColor: AppColors.splashColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.all<Color>(AppColors.highlightColor),
      foregroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
      shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
    ),
  ),
  actionIconTheme: ActionIconThemeData(
    closeButtonIconBuilder: (context) => const Icon(Icons.close, color: AppColors.abyssColor),
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: AppColors.accent100,
    elevation: 0,
    rangePickerElevation: 0,
    shadowColor: AppColors.splashColor,
    rangePickerShadowColor: AppColors.splashColor,
    surfaceTintColor: AppColors.splashColor,
    rangePickerSurfaceTintColor: AppColors.splashColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    headerBackgroundColor: AppColors.primaryColor,
    rangePickerHeaderHeadlineStyle: const TextStyle(
      fontFamily: "Inter",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headerForegroundColor: Colors.white,
    rangePickerHeaderForegroundColor: AppColors.abyssColor,
    rangeSelectionBackgroundColor: AppColors.accent200,
    rangePickerHeaderBackgroundColor: AppColors.primaryColor,
    rangePickerBackgroundColor: AppColors.accent100,
    rangeSelectionOverlayColor: MaterialStateProperty.all(AppColors.splashColor),
    rangePickerHeaderHelpStyle: const TextStyle(
      fontFamily: "Inter",
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headerHeadlineStyle: const TextStyle(
      fontFamily: "Inter",
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    headerHelpStyle: const TextStyle(
      fontFamily: "Inter",
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    weekdayStyle: const TextStyle(
      fontFamily: "Inter",
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.abyssColor,
    ),
    yearStyle: const TextStyle(
      fontFamily: "Inter",
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryColor,
    ),
    dayStyle: const TextStyle(
      fontFamily: "Inter",
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryColor,
    ),
    dayOverlayColor: MaterialStateProperty.all(AppColors.splashColor),
    yearOverlayColor: MaterialStateProperty.all(AppColors.splashColor),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.primaryColor,
    selectionColor: const Color(0xFF3C4A7C).withOpacity(0.40),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    circularTrackColor: Colors.transparent,
    color: AppColors.primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryColor,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.abyssColor,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: AppColors.abyssColor,
    ),
    iconTheme: IconThemeData(color: AppColors.abyssColor, size: 20),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
  ),
  switchTheme: SwitchThemeData(
    overlayColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) return AppColors.primaryColor;
      return AppColors.gray300;
    }),
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) return AppColors.primaryColor;
      return AppColors.gray300;
    }),
    trackColor: MaterialStateProperty.all(const Color(0xFFE0E2D8)),
  ).copyWith(
    thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return AppColors.gray300;
      }
      if (states.contains(MaterialState.selected)) {
        return AppColors.accent500;
      }
      return AppColors.gray300;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return AppColors.gray300;
      }
      if (states.contains(MaterialState.selected)) {
        return AppColors.accent500;
      }
      return AppColors.gray300;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(AppColors.accent500),
  ).copyWith(
    fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return AppColors.gray300;
      }
      if (states.contains(MaterialState.selected)) {
        return AppColors.accent500;
      }
      return AppColors.gray300;
    }),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.accent500;
      }
      return Colors.transparent;
    }),
    overlayColor: MaterialStateProperty.all(AppColors.splashColor),
    side: const BorderSide(
      color: AppColors.gray300,
      width: 1.5,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    checkColor: MaterialStateProperty.all(Colors.white),
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor,
    background: Colors.white,
  ).copyWith(background: Colors.white),
);

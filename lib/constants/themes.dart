import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osit_monitor/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:osit_monitor/constants/styles.dart';

const String kThemeModeBox = 'themeMode';
const String kThemeModeKey = 'themeMode';
const String kSystemMode = 'system';
const String kLightMode = 'light';
const String kDarkMode = 'dark';
const String kDefaultFontFamily = 'Poppins';

abstract class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: ColorValues.primaryColor,
    iconTheme: const IconThemeData(color: ColorValues.whiteColor),
    scaffoldBackgroundColor: ColorValues.lightBgColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorValues.kiomGreen,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 19.r,
      ),
    ),
    cardColor: ColorValues.lightDialogColor,
    shadowColor: ColorValues.shadowColor.withAlpha(12),
    cardTheme: const CardTheme(color: ColorValues.lightDialogColor),
    dialogTheme:
        const DialogTheme(backgroundColor: ColorValues.lightDialogColor),
    dialogBackgroundColor: ColorValues.lightDialogColor,
    bottomSheetTheme: const BottomSheetThemeData().copyWith(
      backgroundColor: ColorValues.lightDialogColor,
      surfaceTintColor: ColorValues.lightDialogColor,
      modalBackgroundColor: ColorValues.lightDialogColor,
      modalBarrierColor: ColorValues.blackColor.withOpacity(0.5),
    ),
    dividerColor: ColorValues.lightDividerColor,
    disabledColor: ColorValues.lightGrayColor,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorValues.darkBgColor,
      contentTextStyle: AppStyles.style14Normal.copyWith(
        color: ColorValues.darkBodyTextColor,
      ),
      actionTextColor: ColorValues.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: const ButtonStyle().copyWith(
        backgroundColor: MaterialStateProperty.all(ColorValues.primaryColor),
        foregroundColor: MaterialStateProperty.all(ColorValues.whiteColor),
        elevation: MaterialStateProperty.all(0.0),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      labelStyle: AppStyles.p.copyWith(
        color: ColorValues.lightBodyTextColor,
      ),
      floatingLabelStyle: AppStyles.p.copyWith(
        color: ColorValues.lightBodyTextColor.withAlpha(140),
      ),
      hintStyle: AppStyles.p.copyWith(
        color: ColorValues.lightBodyTextColor.withAlpha(140),
      ),
      errorStyle: AppStyles.p.copyWith(
        color: ColorValues.errorColor,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.lightDividerColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.lightDividerColor.withAlpha(20),
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.lightDividerColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.primaryColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.errorColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.errorColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
    // fontFamily: kDefaultFontFamily,
    textTheme: const TextTheme().copyWith(
      bodyLarge: const TextStyle(
        color: ColorValues.lightBodyTextColor,
      ),
      bodyMedium: const TextStyle(
        color: ColorValues.lightBodyTextColor,
      ),
      bodySmall: const TextStyle(
        color: ColorValues.lightBodyTextColor,
      ),
      titleMedium: TextStyle(
        color: ColorValues.lightBodyTextColor.withAlpha(180),
      ),
      titleSmall: TextStyle(
        color: ColorValues.lightBodyTextColor.withAlpha(140),
      ),
    ),
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: ColorValues.primaryColor,
    iconTheme: const IconThemeData(color: ColorValues.darkGrayColor),
    scaffoldBackgroundColor: ColorValues.darkBgColor,
    shadowColor: ColorValues.shadowColor.withAlpha(12),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorValues.kiomGreenBlue,
    ),
    cardColor: ColorValues.darkDialogColor,
    cardTheme: const CardTheme(color: ColorValues.darkDialogColor),
    dialogTheme:
        const DialogTheme(backgroundColor: ColorValues.darkDialogColor),
    dialogBackgroundColor: ColorValues.darkDialogColor,
    bottomSheetTheme: const BottomSheetThemeData().copyWith(
      backgroundColor: ColorValues.darkDialogColor,
      surfaceTintColor: ColorValues.darkDialogColor,
      modalBackgroundColor: ColorValues.darkDialogColor,
      modalBarrierColor: ColorValues.blackColor.withOpacity(0.5),
    ),
    dividerColor: ColorValues.darkDividerColor,
    disabledColor: ColorValues.darkGrayColor,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: ColorValues.lightBgColor,
      contentTextStyle: TextStyle(
        color: ColorValues.lightBodyTextColor,
      ),
      actionTextColor: ColorValues.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: const ButtonStyle().copyWith(
        backgroundColor: MaterialStateProperty.all(ColorValues.primaryColor),
        foregroundColor: MaterialStateProperty.all(ColorValues.whiteColor),
        elevation: MaterialStateProperty.all(0.0),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      contentPadding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      labelStyle: AppStyles.p.copyWith(
        color: ColorValues.darkBodyTextColor,
      ),
      floatingLabelStyle: AppStyles.p.copyWith(
        color: ColorValues.darkBodyTextColor.withAlpha(140),
      ),
      hintStyle: AppStyles.p.copyWith(
        color: ColorValues.darkBodyTextColor.withAlpha(140),
      ),
      errorStyle: AppStyles.p.copyWith(
        color: ColorValues.errorColor,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.darkDividerColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.darkDividerColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.darkDividerColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.primaryColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.errorColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorValues.errorColor,
          width: 1.r,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
    fontFamily: kDefaultFontFamily,
    textTheme: const TextTheme().copyWith(
      bodyLarge: const TextStyle(
        color: ColorValues.darkBodyTextColor,
      ),
      bodyMedium: const TextStyle(
        color: ColorValues.darkBodyTextColor,
      ),
      bodySmall: const TextStyle(
        color: ColorValues.darkBodyTextColor,
      ),
      titleMedium: TextStyle(
        color: ColorValues.darkBodyTextColor.withAlpha(180),
      ),
      titleSmall: TextStyle(
        color: ColorValues.darkBodyTextColor.withAlpha(140),
      ),
    ),
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

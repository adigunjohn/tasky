import 'package:flutter/material.dart';
import 'package:tasky/ui/common/app_colours.dart';
import 'package:tasky/ui/common/app_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColours.greenColor,
      primaryContainer: AppColours.whiteColor,
    ),
    scaffoldBackgroundColor: AppColours.grey100Color,
    hintColor: AppColours.grey300Color,
    cardColor: AppColours.grey200Color,
    highlightColor: AppColours.whiteColor,
    textTheme: TextTheme(
      titleLarge: AppStyles.splashText.copyWith(color: AppColours.blackColor),
      bodyLarge: AppStyles.textSize17.copyWith(color: AppColours.blackColor),
      bodyMedium: AppStyles.textSize15.copyWith(color: AppColours.blackColor),
      bodySmall: AppStyles.textSize14.copyWith(color: AppColours.blackColor),
      labelSmall: AppStyles.textSize11.copyWith(color: AppColours.blackColor),
      headlineLarge: AppStyles.textSize23.copyWith(color: AppColours.blackColor),
      headlineSmall: AppStyles.textSize11Grey,
      headlineMedium: AppStyles.textSize15Grey,
        labelMedium: AppStyles.buttonText,
      displayMedium: AppStyles.textSize13Grey,
    ),
    iconTheme: const IconThemeData(color: AppColours.blackColor),
  );


  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColours.greenColor,
      primaryContainer: AppColours.grey900Color,
    ),
    scaffoldBackgroundColor: AppColours.black87Color,
    hintColor: AppColours.grey900Color,
    cardColor: AppColours.grey800Color,
    highlightColor: AppColours.blackColor,
    textTheme: TextTheme(
      titleLarge: AppStyles.splashText.copyWith(color: AppColours.whiteColor),
      bodyLarge: AppStyles.textSize17.copyWith(color: AppColours.whiteColor),
      bodyMedium: AppStyles.textSize15.copyWith(color: AppColours.whiteColor),
      bodySmall: AppStyles.textSize14.copyWith(color: AppColours.whiteColor),
      labelSmall: AppStyles.textSize11.copyWith(color: AppColours.whiteColor),
      headlineLarge: AppStyles.textSize23.copyWith(color: AppColours.whiteColor),
      headlineSmall: AppStyles.textSize11Grey,
      headlineMedium: AppStyles.textSize15Grey,
      labelMedium: AppStyles.buttonText,
      displayMedium: AppStyles.textSize13Grey,
    ),
    iconTheme: const IconThemeData(color: AppColours.whiteColor),
  );
}

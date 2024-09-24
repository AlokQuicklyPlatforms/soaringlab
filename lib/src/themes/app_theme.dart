import 'package:flutter/material.dart';
import 'package:soaring_lab/src/themes/app_fonts.dart';

class AppTheme {
  static const primaryColor = Color.fromARGB(255, 21, 96, 130);
  static const secondaryColor = Color.fromARGB(255, 180, 201, 212);
  static const secondaryColorgrey = Color.fromARGB(255, 232, 232, 232);
  static const titlecard = Color.fromARGB(255, 127, 127, 127);
  //
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        displayLarge: AppFonts.headline1,
        displayMedium: AppFonts.headline2,
        bodyLarge: AppFonts.bodyText1,
        bodyMedium: AppFonts.bodyText2,

        // headline1: AppFonts.headline1,
        // headline2: AppFonts.headline2,
        displaySmall: AppFonts.headline3,
        headlineMedium: AppFonts.headline4,
        headlineSmall: AppFonts.headline5,
        titleLarge: AppFonts.headline6,
        titleMedium: AppFonts.subtitle1,
        titleSmall: AppFonts.subtitle2,
        // bodyLarge: AppFonts.bodyText1,
        // bodyText2: AppFonts.bodyText2,
        bodySmall: AppFonts.caption,
        labelSmall: AppFonts.overline,
        labelLarge: AppFonts.button,
        // Custom text styles
        headlineLarge: AppFonts.customTitle1,
        // headlineMedium: AppFonts.customTitle2,
        // bodyLarge: AppFonts.customBody1,
        // bodyMedium: AppFonts.customBody2,
        // subtitleLarge: AppFonts.customSubtitle1,
        // subtitleMedium: AppFonts.customSubtitle2,
        // captionLarge: AppFonts.customCaption1,
        // captionMedium: AppFonts.customCaption2,
        // overlineLarge: AppFonts.customOverline1,
        // overlineMedium: AppFonts.customOverline2,
      ),
    );
  }
}

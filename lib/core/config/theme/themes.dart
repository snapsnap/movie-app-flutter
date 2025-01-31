import 'package:flutter/material.dart';

import 'colors.dart';
import 'typograph.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  // colorScheme: const ColorScheme.light(),
  colorSchemeSeed: primaryColor,
  brightness: Brightness.light,
  textTheme: TextTheme(
    displayLarge: Typograph.globalFontStyle,
    displayMedium: Typograph.globalFontStyle,
    displaySmall: Typograph.globalFontStyle,
    bodyLarge: Typograph.globalFontStyle,
    bodyMedium: Typograph.globalFontStyle,
    bodySmall: Typograph.globalFontStyle,
    labelMedium: Typograph.globalFontStyle,
    labelSmall: Typograph.globalFontStyle,
    titleLarge: Typograph.globalFontStyle,
    titleMedium: Typograph.globalFontStyle,
    titleSmall: Typograph.globalFontStyle,
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  // colorScheme: const ColorScheme.dark(),
  colorSchemeSeed: primaryColor,
  brightness: Brightness.dark,
  textTheme: TextTheme(
    displayLarge: Typograph.globalFontStyle,
    displayMedium: Typograph.globalFontStyle,
    displaySmall: Typograph.globalFontStyle,
    bodyLarge: Typograph.globalFontStyle,
    bodyMedium: Typograph.globalFontStyle,
    bodySmall: Typograph.globalFontStyle,
    labelMedium: Typograph.globalFontStyle,
    labelSmall: Typograph.globalFontStyle,
    titleLarge: Typograph.globalFontStyle,
    titleMedium: Typograph.globalFontStyle,
    titleSmall: Typograph.globalFontStyle,
  ),
);

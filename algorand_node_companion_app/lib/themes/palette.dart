import 'dart:math';

import 'package:flutter/material.dart';

/// The color palette of our app.
class Palette {
  static const primaryColor = Color(0xFFA30786);
  static const primaryDarkColor = Color(0xFF700059);
  static const primaryLightColor = Color(0xFFD84CB6);

  static const accentColor = Color(0xFFA30786);

  static const activeColor = Color(0xFF70626A);
  static const inactiveColor = Color(0xFF8A8993);

  static const primaryTextColor = Color(0xFF191923);
  static const secondaryTextColor = Color(0xFF8A8993);
  static const tertiaryTextColor = Color(0xFF595965);
  static const primaryButtonTextColor = Color(0xFFFFFFFF);
  static const secondaryButtonTextColor = Color(0xFF191923);
  static const buttonTextColor = Color(0xFFFFFFFF);
  static const hintTextColor = Color(0xFFA4A3AB);
  static const linkTextColor = Color(0xFFA4A3AB);

  static const primaryIconTintColor = Color(0XFF595965);
  static const secondaryIconTintColor = Color(0XFFBEBEC4);
  static const tertiaryIconTintColor = Color(0xFFA4A3AB);

  static const inputFillColor = Color(0xFFFFFFFF);

  static const secondaryButtonBackgroundColor = Color(0xFFF3F3F5);

  static const backgroundColor = Color(0xFFF3F3F5);
  static const backgroundOnPrimary = Color(0xFFF8F8FA);
  static const backgroundNavigationColor = Color(0xFFFFFFFF);
  static const backgroundDarkColor = Color(0xFFFFFFFF);
  static const backgroundLightColor = Color(0xFFFFFFFF);
  static const border = Color(0xFFE1E1ED);
  static const dividerColor = Color(0xFFF3F3F5);

  static const transparent = Colors.transparent;

  static const positiveColor = Color(0xFF1DAD98);
  static const errorColor = Color(0xFFE95050);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

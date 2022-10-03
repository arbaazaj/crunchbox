/* Theme used here is a modified version of flutter's shrine app theme.
 * Here is the github link for the project https://github.com/Bryanmuloni/Flutter-Shrine
 */

import 'package:crunchbox/themes/colors.dart';
import 'package:crunchbox/utils/cut_corners_border.dart';
import 'package:flutter/material.dart';

ThemeData buildShrineTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: kShrineAltDarkGrey,
    scaffoldBackgroundColor: kShrineAltDarkGrey,
    cardColor: kShrineAltDarkGrey,
    errorColor: kShrineErrorRed,
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(color: kShrineAltYellow),
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
    ),
    colorScheme:
    ColorScheme.fromSwatch().copyWith(secondary: kShrineAltDarkGrey),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
    headline5: base.headline5!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    subtitle1: base.subtitle1!.copyWith(fontSize: 18.0),
    caption: base.caption!.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
  )
      .apply(
    //fontFamily: 'Beyno',
    displayColor: kShrineSurfaceWhite,
    bodyColor: kShrineSurfaceWhite,
  );
}

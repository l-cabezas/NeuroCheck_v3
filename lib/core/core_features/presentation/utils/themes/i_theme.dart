import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../presentation/styles/sizes.dart';
import '../colors/i_app_colors.dart';


abstract class ITheme {

  abstract final ThemeData baseTheme;

  abstract final IAppColors appColors;

  //Main
  abstract final Color Primary ;
  abstract final Color accentColor;
  abstract final Color PrimaryColor;

  //Screen
  abstract final Color StatusBarColor;
  abstract final Color ScaffoldBGColor;
  abstract final Color MajorBGColor;
  abstract final Color midnight;

  //Text
  abstract final Color BigTextColor ;
  abstract final Color NormalTextColor;
  abstract final Color SmallTextColor;

  //TextField
  abstract final Color TextFieldFillColor;
  abstract final Color TextFieldTextColor;
  abstract final Color TextFieldHintColor;
  abstract final Color TextFieldCursorColor;
  abstract final Color TextFieldValidationColor;
  abstract final Color TextFieldBorderColor;
  abstract final Color TextFieldErrorBorderColor;
  abstract final Color TextFieldFocusedBorderColor;

  //Icon
  abstract final Color IconColor;

  abstract final ColorScheme colorScheme;

  abstract final AppBarTheme appBarTheme;

  abstract final Color scaffoldBackgroundColor;

  abstract final Color bottomAppBarColor;

  abstract final TextTheme textTheme;

  abstract final Color hintColor;

  abstract final TextSelectionThemeData textSelectionTheme;

  abstract final InputDecorationTheme inputDecorationTheme;

  abstract final IconThemeData iconTheme;

  abstract final ButtonThemeData buttonTheme;

  abstract final ToggleButtonsThemeData toggleButtonsTheme;

  abstract final CardTheme cardTheme;

}

extension ThemeExtension on ITheme {
  ThemeData getThemeData() {
    return baseTheme.copyWith(
      appBarTheme: appBarTheme,
      bottomAppBarColor: bottomAppBarColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      primaryColor: Primary,
      colorScheme: colorScheme,
      iconTheme: iconTheme,
      buttonTheme: buttonTheme,
      toggleButtonsTheme: toggleButtonsTheme,
      textTheme: textTheme,
      hintColor: hintColor,
      textSelectionTheme: textSelectionTheme,
      inputDecorationTheme: inputDecorationTheme,
      cardTheme: cardTheme,
    );
  }
}
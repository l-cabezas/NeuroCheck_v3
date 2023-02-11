
import 'package:flutter/material.dart';

import '../../../../presentation/styles/app_colors.dart';
import '../colors/app_colors_dark.dart';
import '../colors/i_app_colors.dart';
import 'i_theme.dart';

class ThemeDark implements ITheme {
  @override
  final ThemeData baseTheme = ThemeData.dark();

  @override
  final IAppColors appColors = AppColorsDark();

  @override
  late final BigTextColor = appColors.BigTextColor;

  @override
  late final IconColor = appColors.IconColor;

  @override
  late final MajorBGColor = appColors.MajorBGColor;

  @override
  late final NormalTextColor = appColors.NormalTextColor;

  @override
  late final Primary = appColors.Primary;

  @override
  late final PrimaryColor = appColors.PrimaryColor;

  @override
  late final ScaffoldBGColor = appColors.ScaffoldBGColor;

  @override
  late final SmallTextColor = appColors.SmallTextColor;

  @override
  late final StatusBarColor = appColors.StatusBarColor;

  @override
  late final TextFieldBorderColor = appColors.TextFieldBorderColor;

  @override
  late final TextFieldCursorColor = appColors.TextFieldCursorColor;

  @override
  late final TextFieldErrorBorderColor = appColors.TextFieldErrorBorderColor;

  @override
  late final TextFieldFillColor = appColors.TextFieldFillColor;

  @override
  late final TextFieldFocusedBorderColor = appColors.TextFieldFocusedBorderColor;

  @override
  late final TextFieldHintColor = appColors.TextFieldHintColor;

  @override
  late final TextFieldTextColor = appColors.TextFieldTextColor;

  @override
  late final TextFieldValidationColor = appColors.TextFieldValidationColor;

  @override
  late final accentColor = appColors.accentColor;

  @override
  late final midnight = appColors.midnight;


  @override
  late final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: appColors.Primary,
    secondary: appColors.accentColor,
  );

  @override
  late final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: appColors.Primary,
    /*systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
      //For Android
      statusBarColor: appColors.statusBarColor,
      systemNavigationBarColor: appColors.bottomNavBarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),*/
    elevation: 0.0,
  );

  @override
  late final Color scaffoldBackgroundColor = appColors.ScaffoldBGColor;

  @override
  late final Color bottomAppBarColor = appColors.PrimaryColor;

  @override
  late final TextTheme textTheme = TextTheme(
    subtitle1: TextStyle(
      color: appColors.NormalTextColor,
    ),
  );

  @override
  late final Color hintColor = appColors.TextFieldHintColor;

  @override
  late final TextSelectionThemeData textSelectionTheme = TextSelectionThemeData(
    cursorColor: appColors.TextFieldCursorColor,
  );

  @override
  late final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    fillColor: appColors.TextFieldFillColor,
    prefixIconColor: appColors.IconColor,
    suffixIconColor: appColors.IconColor,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: appColors.TextFieldBorderColor,
        width: 0.8,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: appColors.TextFieldFocusedBorderColor,
        width: 0.8,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: appColors.TextFieldBorderColor,
        width: 1.2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: appColors.TextFieldErrorBorderColor,
        width: 0.8,
      ),
    ),
    errorStyle: TextStyle(
      color: appColors.TextFieldErrorBorderColor,
    ),
  );

  @override
  late final IconThemeData iconTheme =
  IconThemeData(color: appColors.IconColor);

  @override
  late final ButtonThemeData buttonTheme = ButtonThemeData(
    buttonColor: appColors.accentColor,
    disabledColor: AppColors.grey,
  );

  @override
  late final ToggleButtonsThemeData toggleButtonsTheme = ToggleButtonsThemeData(
    /*borderColor: appColors.toggleButtonBorderColor,
    selectedColor: appColors.toggleButtonSelectedColor,
    disabledColor: appColors.toggleButtonDisabledColor,*/
  );

  @override
  late final CardTheme cardTheme = CardTheme(
    color: appColors.PrimaryColor,
    shadowColor: AppColors.grey,
  );
}
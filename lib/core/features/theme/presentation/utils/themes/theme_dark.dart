
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/app_colors_dark.dart';
import '../colors/custom_colors.dart';
import '../colors/i_app_colors.dart';
import 'i_theme.dart';

class ThemeDark implements ITheme {
  @override
  final ThemeData baseTheme = ThemeData.dark();

  @override
  final IAppColors appColors = AppColorsDark();

  @override
  late final Color primaryColor = appColors.primaryColor;

  @override
  late final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: appColors.primary,
    secondary: appColors.secondary,
  );

  @override
  late final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: appColors.appBarBGColor,
    systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
      //For Android
      statusBarColor: appColors.statusBarColor,
      systemNavigationBarColor: appColors.bottomNavBarColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    elevation: 0.0,
  );

  @override
  late final Color scaffoldBackgroundColor = appColors.scaffoldBGColor;

  @override
  late final Color bottomAppBarColor = appColors.bottomNavBarColor;

  @override
  late final TextTheme textTheme = TextTheme(
    subtitle1: TextStyle(
      color: appColors.textFieldSubtitle1Color,
    ),
    headline1: TextStyle(color: appColors.textFieldHintColor),
    headline2: TextStyle(color: appColors.customWhiteColor),
    headline3: TextStyle(color: appColors.customWhiteColor),
    headline4: TextStyle(color: appColors.customWhiteColor),
    headline5: TextStyle(color: appColors.textFieldHintColor),
    headline6: TextStyle(color: appColors.textFieldHintColor),
    overline: TextStyle(color: appColors.customWhiteColor),
  );

  @override
  late final Color hintColor = appColors.textFieldHintColor;

  @override
  late final TextSelectionThemeData textSelectionTheme = TextSelectionThemeData(
    cursorColor: appColors.textFieldCursorColor,
  );

  @override
  late final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    fillColor: appColors.textFieldFillColor,
    prefixIconColor: appColors.textFieldPrefixIconColor,
    suffixIconColor: appColors.textFieldSuffixIconColor,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: appColors.textFieldBorderColor,
        width: 0.8,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: appColors.textFieldEnabledBorderColor,
        width: 0.8,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: appColors.textFieldFocusedBorderColor,
        width: 1.2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: appColors.textFieldErrorBorderColor,
        width: 0.8,
      ),
    ),
    errorStyle: TextStyle(
      color: appColors.textFieldErrorStyleColor,
    ),
  );

  @override
  late final IconThemeData iconTheme =
      IconThemeData(color: appColors.iconColor);

  @override
  late final ButtonThemeData buttonTheme = ButtonThemeData(
    buttonColor: appColors.buttonColor,
    disabledColor: appColors.buttonDisabledColor,
  );

  @override
  late final ToggleButtonsThemeData toggleButtonsTheme = ToggleButtonsThemeData(
    borderColor: appColors.toggleButtonBorderColor,
    selectedColor: appColors.toggleButtonSelectedColor,
    disabledColor: appColors.toggleButtonDisabledColor,
  );

  @override
  late final CardTheme cardTheme = CardTheme(
    color: appColors.cardBGColor,
    shadowColor: appColors.cardShadowColor,
  );

  @override
  late final CustomColors customColors = CustomColors(
    font40Color: appColors.customFont40Color,
    font32Color: appColors.customFont32Color,
    font24Color: appColors.customFont24Color,
    font20Color: appColors.customFont20Color,
    font17Color: appColors.customFont17Color,
    font14Color: appColors.customFont14Color,
    font12Color: appColors.customFont12Color,
    whiteColor: appColors.customWhiteColor,
    blackColor: appColors.customBlackColor,
    redColor: appColors.customRedColor,
    greenColor: appColors.customGreenColor,
    greyColor: appColors.customGreyColor,
    marinerColor: appColors.customMarinerColor,
    loadingIndicatorColor: appColors.customLoadingIndicatorColor,
  );

}

import 'package:flutter/material.dart';

import 'i_app_colors.dart';

class AppColorsLight implements IAppColors {

  //Main
  @override
  Color Primary = Color(0xFFAED6F1);
  @override
  Color accentColor = Color(0xFF4b98db);
  @override
  Color PrimaryColor = Color(0xffffffff);

  //Screen
  @override
  Color StatusBarColor = Color(0xFFFAFAFA);
  @override
  Color ScaffoldBGColor = Color(0xFFFAFAFA);
  @override
  Color MajorBGColor = Color(0xffffffff);
  @override
  Color midnight = Color(0xff1F2024);


  //Text
  @override
  Color BigTextColor = Color(0xff000000);

  @override
  Color NormalTextColor = Color(0xff000000);
  @override
  Color SmallTextColor = Color(0xFF858992);


  //TextField
  @override
  Color TextFieldFillColor = Color(0xFFFAFAFA);
  @override
  Color TextFieldTextColor = Color(0xff333333);
  @override
  Color TextFieldHintColor = Color(0xff9b9b9b);
  @override
  Color TextFieldCursorColor = Color(0xff000000);
  @override
  Color TextFieldValidationColor = Color(0xffff0000);
  @override
  Color TextFieldBorderColor = Colors.grey;
  @override
  Color TextFieldErrorBorderColor = Color(0xffff0000);
  @override
  Color TextFieldFocusedBorderColor = Color(0xff8ed7ff);


  //Icon
  @override
  Color IconColor = Color(0xff000000);
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../presentation/styles/sizes.dart';

abstract class CupertinoCustomTheme {
  static BoxDecoration cupertinoFormSectionDecoration(BuildContext context) =>
      BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            Sizes.statusCircleRadius(context),
          ),
        ),
        border: Border.all(
          color:
          Theme.of(context).inputDecorationTheme.border!.borderSide.color,
        ),
      );
}
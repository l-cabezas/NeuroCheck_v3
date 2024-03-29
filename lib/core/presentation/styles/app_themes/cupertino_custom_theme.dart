import 'package:flutter/material.dart';

import '../sizes.dart';

class CupertinoCustomTheme {
  static BoxDecoration cupertinoFormSectionDecoration(BuildContext context) =>
      BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            Sizes.textFieldDefaultRadius(context),
          ),
        ),
        border: Border.all(
          color:
              Theme.of(context).inputDecorationTheme.border!.borderSide.color,
        ),
      );
}

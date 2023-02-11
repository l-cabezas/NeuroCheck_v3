import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/features/theme/presentation/utils/colors/custom_colors.dart';
import '../../../core/styles/font_styles.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_outlined_button.dart';
import '../../../core/widgets/custom_text.dart';

class CardRedButtonComponent extends StatelessWidget {
  final String title;
  final bool isColored;
  final VoidCallback? onPressed;

  const CardRedButtonComponent({
    required this.title,
    required this.isColored,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      height: Sizes.roundedButtonMediumHeight(context),
      width: Sizes.roundedButtonMediumWidth(context),
      side: isColored ? null :  BorderSide(
          color: customColors(context).redColor!,
      ),
      buttonColor:
      isColored
          ? null
          : customColors(context).redColor,
      splashColor: isColored ? null : Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      child: CustomText.h5(
        context,
        title,
        color: customColors(context).whiteColor,
        weight: FontStyles.fontWeightBold,
        alignment: Alignment.center,
      ),
    );
  }
}

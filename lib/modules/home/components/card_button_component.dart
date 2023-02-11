import 'package:flutter/material.dart';

import '../../../core/features/theme/presentation/utils/colors/custom_colors.dart';
import '../../../core/styles/font_styles.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_outlined_button.dart';
import '../../../core/widgets/custom_text.dart';

class CardButtonComponent extends StatelessWidget {
  final String title;
  final bool isColored;
  final VoidCallback? onPressed;

  const CardButtonComponent({
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
      side: BorderSide(color: customColors(context).greyColor!,),
      buttonColor:
      isColored
          ? Colors.transparent
          : Theme.of(context).colorScheme.primary,
      splashColor: isColored
          ? null
          : Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      child: CustomText.h5(
        context,
        title,
        color:  Theme.of(context).textTheme.headline4!.color,
        weight: FontStyles.fontWeightBold,
        alignment: Alignment.center,
      ),
    );
  }
}

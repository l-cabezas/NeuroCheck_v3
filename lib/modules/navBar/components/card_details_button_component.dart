import 'package:flutter/material.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/styles/font_styles.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_button.dart';

class CardDetailsButtonComponent extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CardDetailsButtonComponent({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      child: CustomText.h5(
        context,
        title,
        weight: FontStyles.fontWeightMedium,
        color: AppColors.white,
        alignment: Alignment.center,
      ),
      elevation: 1,
      minWidth: Sizes.textButtonMinWidth(context),
      minHeight: Sizes.textButtonMinHeight(context),
      buttonColor: AppColors.accentColor,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: onPressed,
    );
  }
}

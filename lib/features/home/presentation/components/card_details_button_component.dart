import 'package:flutter/material.dart';

import '../../../../core/presentation/styles/app_colors.dart';
import '../../../../core/presentation/styles/font_styles.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import '../../../../core/presentation/widgets/custom_text_button.dart';

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
      elevation: 1,
      minWidth: Sizes.textButtonMinWidth(context),
      minHeight: Sizes.textButtonMinHeight(context),
      buttonColor: AppColors.accentColorLight,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: onPressed,
      child: CustomText.h5(
        context,
        title,
        weight: FontStyles.fontWeightMedium,
        color: AppColors.white,
        alignment: Alignment.center,
      ),
    );
  }
}

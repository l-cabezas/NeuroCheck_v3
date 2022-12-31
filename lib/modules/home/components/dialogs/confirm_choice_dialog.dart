import 'package:flutter/material.dart';

import '../../../../core/presentation/routing/navigation_service.dart';
import '../../../../core/presentation/services/localization_service.dart';
import '../../../../core/presentation/styles/app_colors.dart';
import '../../../../core/presentation/styles/font_styles.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../../core/presentation/widgets/custom_text.dart';



class ConfirmChoiceDialog extends StatelessWidget {
  final String message;

  const ConfirmChoiceDialog({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.availableScreenWidth(context),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dialogHPaddingMedium(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText.h3(
              context,
              'Estás seguro', //todo: tr
              weight: FontStyles.fontWeightMedium,
            ),
            SizedBox(
              height: Sizes.vMarginComment(context),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: CustomText.h4(
                  context,
                  message,
                ),
              ),
            ),
            SizedBox(
              height: Sizes.vMarginSmall(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.hPaddingSmallest(context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    buttonColor: AppColors.grey,
                    height: Sizes.roundedButtonDialogHeight(context),
                    width: Sizes.roundedButtonSmallWidth(context),
                    onPressed: () {
                      NavigationService.goBack(context);
                    },
                    child: CustomText.h4(
                      context,
                      'cancel',
                      color: const Color(0xffffffff),
                      weight: FontStyles.fontWeightMedium,
                      alignment: Alignment.center,
                    ),
                  ),
                  CustomButton(
                    text: tr(context).confirm,
                    height: Sizes.roundedButtonDialogHeight(context),
                    width: Sizes.roundedButtonSmallWidth(context),
                    onPressed: () {
                      NavigationService.goBack(context, result: [true]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

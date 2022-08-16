import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


import '../../../../core/routing/navigation_service.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/font_styles.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../tasks/models/task_model.dart';


class CancelTaskDialog extends HookWidget {
  final TaskModel taskModel;

  const CancelTaskDialog({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cancelNoteController = useTextEditingController(text: '');

    return SizedBox(
      width: Sizes.availableScreenWidth(context),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dialogHPaddingMedium(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*CustomText.h4(
              context,
              tr(context).reasonForCancelingTheOrder + ':',
            ),
            SizedBox(
              height: Sizes.vMarginSmallest(context),
            ),
            CancelOrderNoteComponent(
              cancelNoteController: _cancelNoteController,
            ),*/
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
                      'Cancel',
                      color: const Color(0xffffffff),
                      weight: FontStyles.fontWeightMedium,
                      alignment: Alignment.center,
                    ),
                  ),
                  CustomButton(
                    text: 'confirm',
                    height: Sizes.roundedButtonDialogHeight(context),
                    width: Sizes.roundedButtonSmallWidth(context),
                    onPressed: () {
                      NavigationService.goBack(
                        context,
                        result: [true, cancelNoteController.text],
                      );
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

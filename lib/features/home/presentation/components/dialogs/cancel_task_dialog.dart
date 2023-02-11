import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/presentation/routing/navigation_service.dart';
import '../../../../../core/presentation/styles/app_colors.dart';
import '../../../../../core/presentation/styles/font_styles.dart';
import '../../../../../core/presentation/styles/sizes.dart';
import '../../../../../core/presentation/widgets/custom_button.dart';
import '../../../../../core/presentation/widgets/custom_text.dart';
import '../../../../tasks/data/models/task_model.dart';


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
                      'Cancel', //todo: tr
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

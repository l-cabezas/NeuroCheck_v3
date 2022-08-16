/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/localization_service.dart';
import '../../../../core/styles/font_styles.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../models/task_model.dart';


class TaskDetailsDialog extends StatelessWidget {
  final TaskModel taskModel;

  const TaskDetailsDialog({
    required this.taskModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.availableScreenWidth(context),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.dialogHPaddingSmall(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Sizes.hMarginSmall(context),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CustomText.h4(
                          context,
                          'tr(context).orderDetails' + ':',
                          underline: true,
                          weight: FontStyles.fontWeightSemiBold,
                        ),
                        SizedBox(
                          height: Sizes.vMarginSmallest(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText.h4(
                              context,
                              tr(context).id + ':',
                            ),
                            CustomText.h4(
                              context,
                              '#${taskModel.orderId!.substring(0, 6)}',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText.h4(
                              context,
                              'tr(context).status' + ':',
                            ),
                            CustomText.h4(
                              context,
                              taskModel.orderStatus,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText.h4(
                              context,
                              tr(context).payment + ':',
                            ),
                            CustomText.h4(
                              context,
                              taskModel.paymentMethod,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Sizes.vMarginSmallest(context),
              ),
              CustomText.h4(
                context,
                tr(context).userDetails + ':',
                underline: true,
                weight: FontStyles.fontWeightSemiBold,
              ),
              SizedBox(
                height: Sizes.vMarginTiny(context),
              ),
              CustomText.h4(
                context,
                taskModel.userName.isEmpty
                    ? tr(context).user + taskModel.userId.substring(0, 6)
                    : taskModel.userName,
                padding: LocalizationService.instance.isAr(context)
                    ? EdgeInsets.only(right: Sizes.hPaddingSmall(context))
                    : EdgeInsets.only(left: Sizes.hPaddingSmall(context)),
              ),
              CustomText.h4(
                context,
                taskModel.addressModel!.state +
                    ', ' +
                    taskModel.addressModel!.city +
                    ', ' +
                    taskModel.addressModel!.street,
                padding: LocalizationService.instance.isAr(context)
                    ? EdgeInsets.only(right: Sizes.hPaddingSmall(context))
                    : EdgeInsets.only(left: Sizes.hPaddingSmall(context)),
              ),
              CustomText.h4(
                context,
                taskModel.addressModel!.mobile,
                padding: LocalizationService.instance.isAr(context)
                    ? EdgeInsets.only(right: Sizes.hPaddingSmall(context))
                    : EdgeInsets.only(left: Sizes.hPaddingSmall(context)),
              ),
              SizedBox(
                height: Sizes.vMarginSmallest(context),
              ),
              CustomText.h4(
                context,
                tr(context).note + ':',
                underline: true,
                weight: FontStyles.fontWeightSemiBold,
              ),
              SizedBox(
                height: Sizes.vMarginTiny(context),
              ),
              CustomText.h4(
                context,
                taskModel.userNote.isEmpty
                    ? tr(context).none
                    : taskModel.userNote,
                padding: LocalizationService.instance.isAr(context)
                    ? EdgeInsets.only(right: Sizes.hPaddingSmall(context))
                    : EdgeInsets.only(left: Sizes.hPaddingSmall(context)),
              ),
              SizedBox(
                height: Sizes.vMarginSmall(context),
              ),
              CustomButton(
                text: tr(context).back,
                height: Sizes.roundedButtonDialogHeight(context),
                width: Sizes.roundedButtonDialogWidth(context),
                onPressed: () {
                  NavigationService.goBack(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

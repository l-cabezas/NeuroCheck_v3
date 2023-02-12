import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/presentation/providers/checkbox_provider.dart';
import 'package:neurocheck/core/presentation/styles/app_colors.dart';

import '../../../core/presentation/services/localization_service.dart';
import '../../../core/presentation/styles/sizes.dart';
import '../../../core/presentation/widgets/custom_text.dart';

class CustomCheckBoxComponent extends ConsumerWidget {
  CustomCheckBoxComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final checkBoxValue = ref.watch(checkBoxProvider);
    return Column(children: [
      CustomText.h3(context, tr(context).questionrol,
          color: AppColors.lightBlack),
      SizedBox(
        height: Sizes.vMarginSmall(context),
      ),
      Row(
        children: [
          SizedBox(
            width: 65,
          ),
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              // CHANGE BORDER RADIUS HERE
              side: BorderSide(width: 30, color: AppColors.red),
            ),
            activeColor: Theme.of(context).iconTheme.color,// Rounded Checkbox
            value: checkBoxValue,
            onChanged: (inputValue) {
              ref
                  .watch(checkBoxProvider.notifier)
                  .changeState(change: !checkBoxValue);
              log('${checkBoxValue.toString()}');
            },
          ),
          CustomText.h4(context, tr(context).yes),
          SizedBox(
            width: 50,
          ),
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              // CHANGE BORDER RADIUS HERE
              side: BorderSide(width: 30, color: AppColors.red),
            ),
            activeColor: Theme.of(context).iconTheme.color,// Rounded Checkbox
            value: !checkBoxValue,
            onChanged: (inputValue) {
              ref
                  .watch(checkBoxProvider.notifier)
                  .changeState(change: !checkBoxValue);
              log('${checkBoxValue.toString()}');
            },
          ),
          CustomText.h4(context, tr(context).no),
        ],
      )
    ]);
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/viewmodels/checkbox_provider.dart';

import '../../core/services/localization_service.dart';
import '../../core/styles/sizes.dart';
import '../../core/widgets/custom_text.dart';

class CustomCheckBoxComponent extends ConsumerWidget {
  CustomCheckBoxComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final checkBoxValue = ref.watch(checkBoxProvider);
    return Column(children: [
      CustomText.h3(context, tr(context).questionrol,
          ),
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
              side: BorderSide(width: 30),
            ), // Rounded Checkbox
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
              side: BorderSide(width: 30),
            ), // Rounded Checkbox
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

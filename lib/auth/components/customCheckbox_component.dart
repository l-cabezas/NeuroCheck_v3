import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/viewmodels/checkbox_provider.dart';
import 'package:neurocheck/core/styles/app_colors.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';

class CustomCheckBoxComponent extends ConsumerWidget {
  CustomCheckBoxComponent({Key? key})
      : super(key: key);

  @override
    Widget build(BuildContext context,ref) {
    final checkBoxValue = ref.watch(checkBoxProvider);
    return Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // CHANGE BORDER RADIUS HERE
            side: BorderSide(
            width: 30,
            color: AppColors.red
            ),
            ), // Rounded Checkbox
            value: checkBoxValue,
            onChanged: (inputValue) {
            ref.watch(checkBoxProvider.notifier)
                .changeState(change: !checkBoxValue);
            },
            ),
          SizedBox(width: 10,),
          CustomText.h5(context, 'Quiero registrarme como Supervisor')
        ],
      );


    }
}
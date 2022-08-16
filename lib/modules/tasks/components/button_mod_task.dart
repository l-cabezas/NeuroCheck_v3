



import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/styles/font_styles.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import 'mod_task_provider.dart';

class ButtonModComponent extends ConsumerWidget {
  const ButtonModComponent(this.value,this.situation, {Key? key}) : super(key: key);

  final bool value;
  final String situation;

  @override
  Widget build(BuildContext context, ref) {
    log('button_mod_task');
    log(value.toString());
    log(situation);
    return Container(
        child: PlatformWidget(
      material: (_, __) {
        InkWell(
          onTap: () => getSituation(situation, ref),
          child: const SharedItemComponent(buttonText: 'Cambiar nombre'),
        );
      },
      cupertino: (_, __) {
        return GestureDetector(
          onTap: () => getSituation(situation, ref),
          child: const SharedItemComponent(buttonText: 'Cambiar nombre'),
        );
      },
    ));
  }

  Function getSituation(String situation,ref){
    log('getSituation');
    final modVM = ref.watch(modTaskProvider);
    switch(situation) {
      case 'name':
        return modVM.setShowDays(toggle(value));
      case 'range':
        return modVM.setShowDays(toggle(value));
      case 'days':
        return modVM.setShowDays(toggle(value));
      default:
        return modVM.setShowDays(toggle(value));
    }
  }


  bool toggle(bool valor){
    return !valor;
  }
}

class SharedItemComponent extends StatelessWidget {
  const SharedItemComponent({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    log('hola');
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.vPaddingSmall(context),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(
          Sizes.dialogSmallRadius(context),
        ),
        border: Border.all(
          width: 1,
          color: AppColors.lightThemePrimary,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withOpacity(0.15),
            offset: const Offset(0, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.logout,
            color: AppColors.lightThemePrimary,
          ),
          SizedBox(
            width: Sizes.hMarginSmall(context),
          ),
          CustomText.h4(
            context,
            buttonText,
            alignment: Alignment.center,
            weight: FontStyles.fontWeightExtraBold,
            color: AppColors.lightThemePrimary,
          ),
        ],
      ),
    );
  }
}






import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/core/styles/app_colors.dart';

import '../../../auth/repos/user_repo.dart';
import '../../../core/styles/font_styles.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';

class UserDetailsComponent extends ConsumerWidget {
  const UserDetailsComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userModel = ref.watch(userRepoProvider).userModel!;

    return Column(
      children: [
        CustomText.h2(
          context,
          userModel.name!.isEmpty
              ? 'User${userModel.uId.substring(0, 6)}'
              : userModel.name!,
          weight: FontStyles.fontWeightBold,
          alignment: Alignment.center,
        ),
        SizedBox(
          height: Sizes.vMarginSmall(context),
        ),
        CustomText.h4(
          context,
          'Correo electrónico: ', // todo: tr
          alignment: Alignment.centerLeft,
          color: AppColors.lightBlack,
        ),
        SizedBox(
          height: Sizes.vMarginSmall(context),
        ),
        CustomText.h4(
          context,
          '${userModel.email}',
          alignment: Alignment.center,
          color: AppColors.lightGray,
        ),
        (userModel.rol != 'supervisor')
        ? SizedBox()
        : Column(
            children:
        [SizedBox(
          height: Sizes.vMarginSmall(context),
        ),
        CustomText.h4(
          context,
          'Rol: ', // todo: tr
        alignment: Alignment.centerLeft,
          color: AppColors.lightBlack,
        ),
        SizedBox(
          height: Sizes.vMarginSmallest(context),
        ),
        CustomText.h4(
          context,
          '${userModel.rol}',
          alignment: Alignment.center,
          color: AppColors.lightGray,
        ),

        SizedBox(
          height: Sizes.vMarginSmall(context),
        ),
        CustomText.h4(
          context,
          'Supervisando a: ', // todo: tr
          alignment: Alignment.centerLeft,
          color: AppColors.lightBlack,
        ),
        SizedBox(
          height: Sizes.vMarginSmall(context),
        ),
        CustomText.h4(
          context,
          '${userModel.emailSup}',
          alignment: Alignment.center,
          color: AppColors.lightGray,
        ),])
      ],
    );
  }
}

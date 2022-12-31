import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/core/presentation/styles/app_colors.dart';

import '../../../../auth/domain/repos/user_repo.dart';
import '../../../../core/presentation/services/localization_service.dart';
import '../../../../core/presentation/styles/font_styles.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/widgets/custom_text.dart';

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
          tr(context).profile_email,
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
          tr(context).profile_rol,
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
          tr(context).profile_sup,
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

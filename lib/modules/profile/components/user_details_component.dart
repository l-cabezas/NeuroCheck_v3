import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        CustomText.h3(
          context,
          userModel.name!.isEmpty
              ? 'User${userModel.uId.substring(0, 6)}'
              : userModel.name!,
          weight: FontStyles.fontWeightBold,
          alignment: Alignment.center,
        ),
        SizedBox(
          height: Sizes.vMarginDot(context),
        ),
        CustomText.h5(
          context,
          userModel.email,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}

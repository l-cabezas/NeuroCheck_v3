import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/localization_service.dart';
import '../styles/app_colors.dart';
import '../styles/app_images.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';
import '../widgets/custom_image.dart';
import '../widgets/custom_text.dart';

//DONDE PONE EL NOMBRE
class MainDrawerBottomComponent extends ConsumerWidget {
  const MainDrawerBottomComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return  Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomText.h3(
            context,
            tr(context).appName,
            weight: FontStyles.fontWeightExtraBold,
            color: AppColors.lightThemePrimary,
          ),
          SizedBox(
            width: Sizes.hMarginComment(context),
          ),
          CustomImage.s4(
            context,
            AppImages.appLogoIcon,
            fit: BoxFit.fill,
          ),
        ],
    );
  }
}

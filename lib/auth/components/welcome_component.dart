import 'package:flutter/material.dart';

import '../../core/services/localization_service.dart';
import '../../core/styles/app_images.dart';
import '../../core/styles/font_styles.dart';
import '../../core/styles/sizes.dart';
import '../../core/widgets/custom_text.dart';


class WelcomeComponent extends StatelessWidget {
  const WelcomeComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.loginIcon,
              width: 220,
              height: 220,
              //padding: EdgeInsets.only(left: Sizes.vMarginExtreme(context)),
            ),
            /*Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Image.asset(
                    AppImages.loginIcon,
                    width: 220,
                    height: 220,
                    //padding: EdgeInsets.only(left: Sizes.vMarginExtreme(context)),
                  ),

              ]),
            Column(children: [
              Image.asset(
                AppImages.loginIcon2,
                width: 200,
                height: 220,
                //padding: EdgeInsets.only(left: Sizes.vMarginExtreme(context)),
              )
            ],)*/

          ],
        ),
        SizedBox(
          height: Sizes.vMarginSmall(context),
        ),
        CustomText.h4(
          context,
          tr(context).signInToYourAccount,
          weight: FontStyles.fontWeightMedium,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/presentation/services/localization_service.dart';
import '../../../core/presentation/styles/app_colors.dart';
import '../../../core/presentation/styles/app_images.dart';
import '../../../core/presentation/styles/sizes.dart';
import '../../../core/presentation/utils/dialogs.dart';
import '../../../core/presentation/widgets/custom_image.dart';
import '../../../core/presentation/widgets/custom_text.dart';

class AppLogoComponent extends StatelessWidget {
  const AppLogoComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImage(
          context,
          AppImages.loginIcon,
          //height: Sizes.loginLogoSize(context),
          //width: Sizes.loginLogoSize(context),
          fit: BoxFit.cover,
          //imageAndTitleAlignment: MainAxisAlignment.start,
        ),
        SizedBox(
          height: Sizes.vMarginSmallest(context),
        ),

        Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
            Container(
              child: CustomText.h1(
              context,
              //tr(context).welcome,
              alignment: Alignment.center,
              tr(context).signInToYourAccount,
              color: AppColors.grey,
            ),),
          //SizedBox(width: Sizes.vMarginExtreme(context),),
              Container(
                padding: EdgeInsets.only(
                  //top: Sizes.hMarginExtreme(context),
                  //bottom: Sizes.vMarginSmallest(context),
                  //right: Sizes.vMarginSmall(context),
                  left: Sizes.vMarginExtreme(context) + 7,
                ),
                alignment: Alignment.topRight,
                child: IconButton(
                    alignment: Alignment.center,
                    onPressed: (){
                      AppDialogs.showInfo(context,message: tr(context).info_login);
                    },
                    icon: const Icon(Icons.info_outline, color: AppColors.lightThemePrimary,)
                ),
              ),
        ]),

      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neurocheck/core/presentation/screens/popup_page.dart';

import '../hooks/fade_in_controller_hook.dart';
import '../providers/splash_provider.dart';
import '../services/localization_service.dart';
import '../styles/app_images.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';
import '../widgets/custom_text.dart';


//pantalla de carga
class SplashScreen extends HookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final fadeController = useFadeInController();
    ref.watch(splashProvider);

    return PopUpPage(
      body: FadeIn(
        curve: Curves.easeIn,
        controller: fadeController,
        child: Stack(
          children: [
            /*Image.asset(
              AppImages.splash,
              height: Sizes.fullScreenHeight(context),
              width: Sizes.fullScreenWidth(context),
              fit: BoxFit.cover,
            ),*/
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  AppImages.splashAnimation,
                  width: Sizes.splashLogoSize(context),
                ),
                SizedBox(
                  height: Sizes.vMarginSmallest(context),
                ),
                CustomText.h1(
                  context,
                  tr(context).appName,
                  weight: FontStyles.fontWeightExtraBold,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

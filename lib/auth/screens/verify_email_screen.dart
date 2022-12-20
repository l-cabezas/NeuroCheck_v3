import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/styles/app_colors.dart';

import '../../core/routing/navigation_service.dart';
import '../../core/routing/route_paths.dart';
import '../../core/screens/popup_page.dart';
import '../../core/services/localization_service.dart';
import '../../core/styles/sizes.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/loading_indicators.dart';
import '../components/verifyEmailFormComponent.dart';
import '../repos/auth_repo.dart';
import '../viewmodels/auth_provider.dart';
import '../viewmodels/auth_state.dart';

class VerifyEmailScreen extends ConsumerWidget {
  const VerifyEmailScreen({
    Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    return PopUpPage(
              body: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  padding: EdgeInsets.symmetric(
                    vertical: Sizes.screenVPaddingHigh(context),
                    horizontal: Sizes.screenHPaddingDefault(context),
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //const AppLogoComponent(),
                        SizedBox(
                          height: Sizes.vMarginHigh(context),
                        ),
                        //const WelcomeComponent(),
                        SizedBox(
                          height: Sizes.vMarginHigh(context),
                        ),
                        //const VerifyEmailFormComponent(),
                        VerifyEmailFormComponent(),
                        SizedBox(
                          height: Sizes.vMarginSmall(context),
                        ),
                        CustomButton(
                          text: tr(context).cancelBtn,
                          buttonColor: AppColors.white,
                          onPressed: () {
                            NavigationService.push(
                              context,
                              isNamed: true,
                              page: RoutePaths.authLogin,
                            );
                          },
                        ),
                        SizedBox(
                          height: Sizes.vMarginHigh(context),
                        ),
                      ]),
                ),
              ),
            );
          }

}

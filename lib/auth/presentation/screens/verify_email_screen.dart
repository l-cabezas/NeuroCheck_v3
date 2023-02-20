import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/presentation/styles/app_colors.dart';

import '../../../core/presentation/routing/navigation_service.dart';
import '../../../core/presentation/routing/route_paths.dart';
import '../../../core/presentation/screens/popup_page.dart';
import '../../../core/presentation/services/localization_service.dart';
import '../../../core/presentation/styles/sizes.dart';
import '../../../core/presentation/widgets/custom_button.dart';
import '../../../core/presentation/widgets/custom_text.dart';
import '../../../core/presentation/widgets/loading_indicators.dart';
import '../components/verifyEmailFormComponent.dart';
import '../../data/repos/auth_repo.dart';
import '../../domain/repos/user_repo.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';

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
                          buttonColor: AppColors.lightRed,
                          onPressed: () {
                            ref.watch(userRepoProvider)
                                .deleteUidBD(GetStorage().read('uidUsuario'));
                            ref.watch(authRepoProvider).deleteUser();
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

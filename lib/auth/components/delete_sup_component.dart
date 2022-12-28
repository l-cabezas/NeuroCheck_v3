import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/repos/auth_repo.dart';
import 'package:neurocheck/auth/repos/user_repo.dart';
import 'package:neurocheck/core/styles/app_colors.dart';
import '../../core/routing/navigation_service.dart';
import '../../core/routing/route_paths.dart';
import '../../core/services/localization_service.dart';
import '../../core/styles/sizes.dart';
import '../../core/widgets/custom_button.dart';
import '../viewmodels/auth_provider.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';


class DeleteSupComponent extends HookConsumerWidget {
  const DeleteSupComponent({Key? key}) : super(key: key);
//todo: tr
  @override
  Widget build(BuildContext context, ref){
            return Column(
                children: [
                  Center(
                    child: CustomText.h2(
                        context, color: AppColors.darkGray,
                        'Error al añadir supervisado'),
                  ),
                  SizedBox(
                    height: Sizes.vMarginMedium(context),
                  ),
                  Center(
                    child: CustomText.h3(
                        context, color: AppColors.darkGray,
                        'El supervisado añadido ya es supervisor de otra cuenta'
                            'tienes que añadir otra cuenta que no tenga ese rol.'),
                  ),
                  SizedBox(
                    height: Sizes.vMarginHigh(context),
                  ),
                  CustomButton(
                    text: 'Volver',
                    onPressed: () {

                      ref.watch(userRepoProvider)
                          .deleteSupUid(GetStorage().read('uidSup'));

                      GetStorage().write('emailSup', '');
                      GetStorage().write('passwSup', '');
                      GetStorage().write('uidSup', '');

                      navigationToAddSup(context);
                    },
                  ),
                  SizedBox(
                    height: Sizes.vMarginSmall(context),
                  ),
                ]
            );

  }

  navigationToAddSup(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.addSup,
    );
  }
}

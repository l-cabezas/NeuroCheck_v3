import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/data/repos/auth_repo.dart';
import 'package:neurocheck/auth/presentation/components/register_supervised_text_fields.dart';
import 'package:neurocheck/core/presentation/styles/app_colors.dart';
import 'package:neurocheck/core/presentation/utils/dialogs.dart';
import 'package:neurocheck/core/presentation/providers/main_core_provider.dart';

import '../../../core/presentation/routing/navigation_service.dart';
import '../../../core/presentation/routing/route_paths.dart';
import '../../../core/presentation/widgets/custom_text.dart';
import '../../../core/presentation/widgets/custom_text_button.dart';
import '../providers/auth_provider.dart';
import '../../../core/presentation/services/localization_service.dart';
import '../../../core/presentation/styles/sizes.dart';
import '../../../core/presentation/widgets/custom_button.dart';
import '../../../core/presentation/widgets/loading_indicators.dart';

class RegisterSupervisedFormComponent extends HookConsumerWidget {
  const RegisterSupervisedFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loginFormKey = useMemoized(() => GlobalKey<FormState>());
    final emailControllerSupervised = useTextEditingController(text: '');
    final passwordControllerSupervised = useTextEditingController(text: '');

    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          RegisterSupervisedTextFieldsSection(
            emailControllerSupervised: emailControllerSupervised,
            passwordControllerSupervised: passwordControllerSupervised,
            onFieldSubmitted: (value) {
              if (loginFormKey.currentState!.validate()) {
                ref.read(authProvider.notifier).signSupervisedIn(
                  context,
                  emailSupervised: emailControllerSupervised.text,
                  passwordSupervised: passwordControllerSupervised.text,
                );
              }
            },
          ),
          SizedBox(height: Sizes.vMarginSmall(context),),
          //boton
          Consumer(
            builder: (context, ref, child) {
              final authLoading = ref.watch(
                authProvider.select((state) =>
                    state.maybeWhen(loading: () => true, orElse: () => false)),
              );
              return authLoading
                  ? LoadingIndicators.instance.smallLoadingAnimation(
                context,
                width: Sizes.loadingAnimationButton(context),
                height: Sizes.loadingAnimationButton(context),
              )
                  : CustomButton(
                text: tr(context).addSupervised,
                onPressed: () {
                  if (loginFormKey.currentState!.validate()) {
                    ref.watch(authProvider.notifier)
                        .signSupervisedIn(
                      context,
                      emailSupervised: emailControllerSupervised.text,
                      passwordSupervised: passwordControllerSupervised.text,
                    );
                  }
                },
              );
            },
          ),
          SizedBox(height: Sizes.vMarginMedium(context),),
          (GetStorage().read('uidSup') == '')
           ? CustomButton(
                text: tr(context).cancel,
                buttonColor: AppColors.lightRed,
                onPressed: () {
                  showAlertDialogDelete( context, ref);
                }
            )
           : SizedBox()
        ],
      ),
    );
  }

  showAlertDialogDelete(BuildContext context, ref) {
    // set up the buttons
    Widget okButton = CustomTextButton(
      child: CustomText.h4(
          context,
          tr(context).delete,
          color: AppColors.blue
      ),
      onPressed:  () {
        NavigationService.pushReplacementAll(
          context,
          isNamed: true,
          page: RoutePaths.authLogin,
        );
        ref.watch(mainCoreProvider).deleteAccount();
      },
    );

    Widget cancelButton = CustomTextButton(
      child: CustomText.h4(
          context,
          tr(context).cancel,
          color: AppColors.red
      ),
      onPressed:  () {
        NavigationService.goBack(context,rootNavigator: true);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: CustomText.h2(context, tr(context).cancelSupAviso),
      content: CustomText.h3(context,tr(context).cancelAddSup), // todo: tr
      actions: [
        cancelButton,
        okButton,
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/styles/app_colors.dart';
import 'package:neurocheck/core/viewmodels/main_core_provider.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';

import '../../core/routing/navigation_service.dart';
import '../../core/routing/route_paths.dart';
import '../../core/styles/sizes.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/loading_indicators.dart';
import '../viewmodels/auth_provider.dart';

class VerifyEmailFormComponent extends HookConsumerWidget {
  const VerifyEmailFormComponent({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, ref) {
    return
      Column(
        children: [
          Center(
            child: CustomText.h2(
              context, color: AppColors.darkGray,'Verifique su email para poder usar la app'),
          ),
          SizedBox(
            height: Sizes.vMarginSmall(context),
          ),
          Center(
            child: CustomText.h3(
                context, color: AppColors.darkGray,'Revise si tiene el correo electrónico de verificacion '
                '(si no le aparece baya a la seccion de spam) '
                'y si no tiene el correo pulse el botón de reenviar y compruebe de nuevo'),
          ),
          SizedBox(
            height: Sizes.vMarginSmall(context),
          ),
          //todo: poner fotico o algo
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
                text: 'Reenviar',
                onPressed: () {
                    ref.watch(authProvider.notifier)
                        .enviarEmailVerification(context);

                },
              );
            },
          ),
          SizedBox(
            height: Sizes.vMarginSmall(context),
          ),
          CustomButton(
            text: 'Refresh',
            onPressed: () {
              FirebaseAuth.instance.currentUser!.reload();
              ref.refresh(authProvider);
              log('refresh ${FirebaseAuth.instance.currentUser?.emailVerified}');
              var done = FirebaseAuth.instance.currentUser?.emailVerified;
              if(done!){
                NavigationService.pushReplacementAll(
                  NavigationService.context,
                  isNamed: true,
                  page: RoutePaths.addSup,
                  arguments: {'offAll': true},
                );
              }
            },
          )
        ],
      );
  }
}
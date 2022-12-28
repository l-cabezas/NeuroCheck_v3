import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/repos/auth_repo.dart';
import 'package:neurocheck/core/styles/app_colors.dart';
import 'package:neurocheck/core/viewmodels/main_core_provider.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';

import '../../core/routing/navigation_service.dart';
import '../../core/routing/route_paths.dart';
import '../../core/services/localization_service.dart';
import '../../core/styles/sizes.dart';
import '../../core/utils/dialogs.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/loading_indicators.dart';
import '../viewmodels/auth_provider.dart';
import '../viewmodels/auth_state.dart';

class VerifyEmailFormComponent extends HookConsumerWidget {
   const VerifyEmailFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref){
  final _authStream = ref.watch(bossValidProvider);
  return _authStream.when(
      data: (authValid) {
     if(authValid!){
       return Column(
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
                 children:[
                   Center(
                     child: CustomText.h2(
                         context, color: AppColors.darkGray,
                         tr(context).register_user
                     ),
                   ),
                   IconButton(
                       alignment: Alignment.center,
                       onPressed: (){
                         AppDialogs.showInfo(context,message: tr(context).info_verify);
                       },
                       icon: const Icon(Icons.info_outline, color: AppColors.darkGray,)
                   ),
                 ]),
             SizedBox(
               height: Sizes.vMarginMedium(context),
             ),
             Center(
               child: CustomText.h3(
                   context, color: AppColors.darkGray,
                   tr(context).register_text), // todo: tr
             ),
             SizedBox(
               height: Sizes.vMarginMedium(context),
             ),
               Center(
                 child: CustomButton(
                       text: tr(context).register_user,
                       onPressed: () {
                          navigationToAddSup(context);
                       },
                     )
                  )
           ]
       );
     }
     else{
       return Column(
             children: [
               Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children:[
                     Center(
                 child: CustomText.h2(
                     context, color: AppColors.darkGray,
                     tr(context).verifyTitle),
               ),
               IconButton(
               alignment: Alignment.center,
               onPressed: (){
               AppDialogs.showInfo(context,message: tr(context).info_verify);
               },
               icon: const Icon(Icons.info_outline, color: AppColors.darkGray,)
               ),
                   ]),
               SizedBox(
                 height: Sizes.vMarginMedium(context),
               ),
               Center(
                 child: CustomText.h3(
                     context, color: AppColors.darkGray,
                     tr(context).verifyMessage),
               ),
               SizedBox(
                 height: Sizes.vMarginHigh(context),
               ),
               //todo: poner fotico o algo
               //boton
               CustomButton(
                 text: tr(context).send,
                 onPressed: () {
                   ref.watch(authProvider.notifier)
                       .enviarEmailVerification(context);
                 },
               ),
               SizedBox(
                 height: Sizes.vMarginSmall(context),
               ),
             ]);
     }
      },
      error: (err, stack) => CustomText.h4(
    context,
      tr(context).somethingWentWrong + '\n' + tr(context).pleaseTryAgainLater,
      color: AppColors.grey,
      alignment: Alignment.center,
      textAlign: TextAlign.center,
    ),
      loading: () => LoadingIndicators.instance.smallLoadingAnimation(context)
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

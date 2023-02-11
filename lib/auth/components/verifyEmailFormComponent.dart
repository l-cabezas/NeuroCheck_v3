import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/widgets/custom_text.dart';

import '../../core/routing/navigation_service.dart';
import '../../core/routing/route_paths.dart';
import '../../core/services/localization_service.dart';
import '../../core/styles/sizes.dart';
import '../../core/utils/dialogs.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/loading_indicators.dart';
import '../viewmodels/auth_provider.dart';

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
                         context,
                         tr(context).register_user
                     ),
                   ),
                   IconButton(
                       alignment: Alignment.center,
                       onPressed: (){
                         AppDialogs.showInfo(context,message: tr(context).info_verify);
                       },
                       icon: const Icon(Icons.info_outline,)
                   ),
                 ]),
             SizedBox(
               height: Sizes.vMarginMedium(context),
             ),
             Center(
               child: CustomText.h3(
                   context,
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
                     context,
                     tr(context).verifyTitle),
               ),
               IconButton(
               alignment: Alignment.center,
               onPressed: (){
               AppDialogs.showInfo(context,message: tr(context).info_verify);
               },
               icon: const Icon(Icons.info_outline, )
               ),
                   ]),
               SizedBox(
                 height: Sizes.vMarginMedium(context),
               ),
               Center(
                 child: CustomText.h3(
                     context,
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
      alignment: Alignment.center,
      textAlign: TextAlign.center,
    ),
      loading: () => LoadingIndicators.smallLoadingAnimation(context)
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

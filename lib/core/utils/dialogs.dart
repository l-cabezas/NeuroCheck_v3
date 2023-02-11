

import 'dart:developer';

import 'package:flutter/material.dart';

import '../../modules/tasks/viewmodels/task_provider.dart';
import '../routing/navigation_service.dart';
import '../routing/route_paths.dart';
import '../services/localization_service.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_text.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/loading_indicators.dart';
import 'dialog_message_state.dart';



abstract class AppDialogs {
  static Future showErrorDialog(BuildContext context, {String? message}) async {
    await DialogWidget.showCustomDialog(
      context: context,
      dialogWidgetState: DialogWidgetState.error,
      title: tr(context).oops,
      description: '${tr(context).somethingWentWrong}\n${message ?? tr(context).pleaseTryAgainLater}',
      textButton: tr(context).oK,
      onPressed: () {
        NavigationService.goBack(context,rootNavigator: true);
      },
    );
  }

  static Future showCheckDialog(BuildContext context, {String? message}) async {
    await DialogWidget.showCustomDialog(
      context: context,
      dialogWidgetState: DialogWidgetState.question,
      title: tr(context).oops,
      description: '${tr(context).somethingWentWrong}\n${message ?? tr(context).pleaseTryAgainLater}',
      textButton: tr(context).oK,
      textButton2: tr(context).cancel,
      onPressed: () {
        log('aceptar');
        TaskNotifier.aceptar = true;
        NavigationService.goBack(context,rootNavigator: true);
      },
      onPressed2: (){
        log('NO aceptar');
        TaskNotifier.aceptar = false;
        NavigationService.goBack(context,rootNavigator: true);
      }
    );
  }

  static Future showErrorNeutral(BuildContext context, {String? message}) async {
    await DialogWidget.showCustomDialog(
      context: context,
      dialogWidgetState: DialogWidgetState.error,
      title: tr(context).oops,
      description: message!,
      textButton: tr(context).oK,
      onPressed: () {
        NavigationService.goBack(context,rootNavigator: true);
      },
    );
  }

  static Future showInfo(BuildContext context, {String? message}) async {
    await DialogWidget.showCustomDialog(
      context: context,
      dialogWidgetState: DialogWidgetState.info,
      title: tr(context).info,
      description: message!,
      backgroundColor: Theme.of(context).colorScheme.primary,
      textButton: tr(context).oK,
      onPressed: () {
        NavigationService.goBack(context,rootNavigator: true);
      },
    );
  }

  static Future addTaskOK(BuildContext context, {String? message}) async {
    await DialogWidget.showCustomDialog(
      context: context,
      dialogWidgetState: DialogWidgetState.correct,
      title: message,
      textButton: tr(context).oK,
      onPressed: () {
        NavigationService.goBack(context,rootNavigator: true);
      },
    );
  }

  static Future signOutOk(BuildContext context, {String? message}) async {
    await DialogWidget.showCustomDialog(
      context: context,
      dialogWidgetState: DialogWidgetState.correct,
      title: message,
      textButton: tr(context).oK,
      onPressed: () {
        //NavigationService.goBack(context,rootNavigator: true);
        //Phoenix.rebirth(context);
        NavigationService.pushReplacementAll(
          NavigationService.context,
          isNamed: true,
          rootNavigator: true,
          page: RoutePaths.authLogin,
        );
      },
    );
  }

  static Future showLoadingDialog(BuildContext context) async {
    return await NewCustomDialog.showDialog(
      context,
      barrierDismissible: false,
      contentPadding: EdgeInsets.symmetric(
        vertical: Sizes.dialogPaddingV30(context),
        horizontal: Sizes.dialogPaddingH20(context),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Sizes.dialogRadius20(context),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LoadingIndicators.smallLoadingAnimation(
            context,
            width: Sizes.loadingAnimationButton(context),
            height: Sizes.loadingAnimationButton(context),
          ),
          SizedBox(
            height: Sizes.vPaddingSmall(context),
          ),
          CustomText.f18(
            context,
            'Cargando', //todo: tr
            alignment: Alignment.center,
            weight: FontStyles.fontWeightMedium,
          ),
        ],
      ),
    );
  }


  static Future showWarning(BuildContext context, {String? message}) async {
    await DialogWidget.showCustomDialog(
      context: context,
      dialogWidgetState: DialogWidgetState.warning,
      title: tr(context).fill_core,
      textButton: tr(context).oK,
      onPressed: () {
        NavigationService.goBack(context,rootNavigator: true);
      },
    );
  }

  static Future showWarningAddRange(BuildContext context, {String? message}) async {
    await DialogWidget.showCustomDialog(
      context: context,
      dialogWidgetState: DialogWidgetState.warning,
      title: tr(context).rangeAdd,
      textButton: tr(context).oK,
      onPressed: () {
        NavigationService.goBack(context,rootNavigator: true);
      },
    );
  }


}


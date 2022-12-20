import 'package:flutter/material.dart';

import '../../modules/tasks/screens/add_task_screen.dart';
import '../routing/app_router.dart';
import '../routing/navigation_service.dart';
import '../routing/route_paths.dart';
import '../services/localization_service.dart';
import '../widgets/dialog_widget.dart';
import 'dialog_message_state.dart';
import 'dialog_widget_state.dart';



class AppDialogs {
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

  //TODO STRING
  static Future showWarning(BuildContext context, {String? message}) async {
    await DialogWidget.showCustomDialog(
      context: context,
      dialogWidgetState: DialogWidgetState.warning,
      title: 'Rellena todos los campos',
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


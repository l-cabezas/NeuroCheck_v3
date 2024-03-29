import 'package:flutter/material.dart';

import '../routing/navigation_service.dart';
import '../styles/sizes.dart';
import '../utils/dialog_message_state.dart';
import '../utils/dialog_widget_state.dart';
import 'custom_dialog.dart';


class DialogWidget {
  static Future showCustomDialog({
    required BuildContext context,
    String? title,
    String? textButton,
    String? textButton2,
    Function? onPressed,
    Function? onPressed2,
    String? image,
    Widget? footer,
    String description = '',
    ShapeBorder? shape,
    Color? backgroundColor,
    EdgeInsetsGeometry? contentPadding,
    Widget? child,
    bool barrierDismissible = true,
    DialogWidgetState dialogWidgetState = DialogWidgetState.info,
  }) async {
    assert(!((title == null || textButton == null) && child == null));
    return await showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      transitionBuilder: (ctx, a1, a2, widget) => Transform.scale(
        scale: a1.value,
        child: WillPopScope(
          onWillPop: () => Future.value(barrierDismissible),
          child: Opacity(
            opacity: a1.value,
            child: CustomDialog(
              context,
              contentPadding: contentPadding,
              buttonText2: textButton2,
              onPressed2: onPressed2 ?? NavigationService.goBack,
              title: title,
              image: image ?? dialogMessageData[dialogWidgetState]['icon'],
              buttonText: textButton,
              footer: footer,
              onPressed: onPressed ?? NavigationService.goBack,
              description: description,
              backgroundColor: const Color(0xffffffff),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                Sizes.dialogRadius(context),
              )),
              child: child,
            ),
          ),
        ),
      ),
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          const SizedBox(),
    );
  }
}

/*
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:neurocheck/core/styles/app_colors.dart';

class FlushBarNotification {
  ///[showError] is the method that shows the error
  /// [message] is the message of the error
  /// [context] is the context of the error
  static Future<void> showError({
    required BuildContext context,
    required String message,
  }) {
    return Flushbar(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      message: message,
      duration: const Duration(seconds: 3),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      backgroundGradient: LinearGradient(
        colors: [AppColors.blue, Colors.white],
        stops: const [1, 1],
      ),
      //title: title,
      icon: Icon(
        Icons.done_outline,
        size: 28,
        color: AppColors.lightBlue,
      ),
      boxShadows: const [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
    ).show(context);
  }
}
class FlushBarComponent extends StatelessWidget {
  final String message;

  const FlushBarComponent({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flushbar(
      duration: const Duration(seconds: 3),
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      */
/*backgroundGradient: LinearGradient(
        colors: [AppColors.blue, Colors.white],
        stops: const [1, 1],
      ),*//*

      boxShadows: const [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      //title: title,
      message: message,
      icon: Icon(
        Icons.done_outline,
        size: 28,
        //color: AppColors.lightBlue,
      ),
    );
  }

}*/

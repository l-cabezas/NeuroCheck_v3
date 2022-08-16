import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ShowInfo{
  showMessage(BuildContext context, String mensaje){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(50),
            elevation: 30,
            dismissDirection: DismissDirection.vertical,
            duration: const Duration(seconds: 3),
            content: Text(mensaje, style: const TextStyle(color: Colors.white),)
        )
    );
  }

  Future<void> showMyDialog(BuildContext context, String mes1,String mes2) async {

    if(mes1.isEmpty){mes1='';}
    if(mes2.isEmpty){mes2 = '';}
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cuidado'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(mes1),
                Text(mes2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showDismissableFlushbar(BuildContext context, String message) {
    Flushbar(
      duration: const Duration(seconds: 3),
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      backgroundGradient: LinearGradient(
        colors: [Theme.of(context).bottomAppBarColor, Colors.white],
        stops: const [1, 1],
      ),
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
        color: Theme.of(context).primaryColor,
      ),
    ).show(context);
  }

}
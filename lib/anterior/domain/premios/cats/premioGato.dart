import 'package:flutter/material.dart';



class PremioGato {
  alertGato(BuildContext context, String gato){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Gatete'),
          content: Container(
            child: (gato.isNotEmpty)
                ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(gato)
                ])

                : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network('https://ih1.redbubble.net/image.1324600626.5649/flat,750x,075,f-pad,750x1000,f8f8f8.jpg'),
                ])
            ,),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


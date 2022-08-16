import 'package:flutter/material.dart';


class PremioPerro {
  alertPerro(BuildContext context, String perro){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Perrete'),
          content: Container(
            child: ( perro.isNotEmpty)
                ? Image.network(perro)
                : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network('https://cdn140.picsart.com/334012617052211.png'),
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


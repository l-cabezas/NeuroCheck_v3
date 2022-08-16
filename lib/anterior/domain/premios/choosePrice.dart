import '/domain/premios/capibara/capibara.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cats/premioGato.dart';
import 'dogs/premioPerro.dart';

class ChoosePrice{
  alertChoose(BuildContext context, String gato, String perro){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Elige micro Premio'),
          content: Container(
              child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoButton.filled(child: const Text('Gato'),
                        onPressed: (){
                          PremioGato().alertGato(context,gato);
                        }
                    ),

                    const SizedBox(height: 20,),
                    CupertinoButton.filled(child: const Text('Perro'),
                        onPressed: (){
                          PremioPerro().alertPerro(context,perro);
                        }),
                    const SizedBox(height: 20,),
                    CupertinoButton.filled(child: const Text('Ninguno'),
                        onPressed: (){
                          Capibara().alertCapibara(context,267);
                        }
                    ),

                  ])),
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

  bool getPremio(int puntos){
    if(puntos % 10 == 0){
      return true;
    }
    else {
      return false;
    }
  }
}
import 'package:flutter/material.dart';

class Capibara{
  String esta = 'assets/capibaras/capibara.jpg';
  String capibaraToca(int toca){
    toca = toca % 300;
    if(toca<10){
      return esta = 'assets/capibaras/capibara.jpg';
    }
    if(toca > 10 && toca < 150){
      return esta = 'assets/capibaras/capibara2.jpg';
    }
    if(toca>150){
      return esta = 'assets/capibaras/capibara3.jpg';
    }
    if(toca> 250){
      return esta = 'assets/capibaras/capibara.jpg';
    }
    return 'No hay capibara...';
  }

  Widget imagen(int toca){
    if(toca <= 10){
      return Column(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Image.asset(capibaraToca(toca)),
            const SizedBox(height: 15,),
            const Text('Esto es una capibara, tu lo has elegido, no va a cambiar la foto', textAlign: TextAlign.center,),

          ]);
    }

    if(toca > 10 && toca < 150){
      return Column(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Image.asset(capibaraToca(toca)),
            const SizedBox(height: 15,),
            const Text('Esto es una capibara, quizás si ha cambiado la foto, ¡bien hecho!'
              , textAlign: TextAlign.center,),
          ]);
    }

    if(toca >= 150 && toca < 250){
      return Column(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Image.asset(capibaraToca(toca)),
            const SizedBox(height: 15,),
            const Text('Esto es una capibara, '
                'definitivamente es otra foto, ¡felicidades!'
              , textAlign: TextAlign.center,),
          ]);
    }

    if(toca > 250){
      return Column(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Image.asset(capibaraToca(toca)),
            const SizedBox(height: 15,),
            const Text('Esto es una capibara, '
                'ha vuelto a su estado original de lo bien que lo haces, '
                '¡Sigue así y seguro que el ciclo reinicia!'
              , textAlign: TextAlign.center,),
          ]);
    }

    return const Text('No hay capibara...');
  }
  alertCapibara(BuildContext context, int toca){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Capibara'),
          content: Center(
            child: imagen(toca)
          ),
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
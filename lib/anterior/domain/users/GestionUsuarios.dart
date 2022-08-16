import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../presentation/mensajes/showInfo.dart';
import '/domain/resources/Strings.dart';
import '../competicion/CompeticionUsuarios.dart';
import '/data/global_var/globals.dart' as globals;


class GestionUsuarios{

  //inicializacion
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var users = FirebaseFirestore.instance.collection("usuarios");

  CompeticionUsuarios tablaUsuarios = CompeticionUsuarios();

  //Añadir datos para registrar a un supervisado
  addSupervisado(BuildContext context) {
    users.doc(globals.user_email).set({
      'fullname': globals.nombre_persona,
      'email': globals.user_email, // Stokes and Sons
      'rol': globals.user_rol, // 42
    }).then((_) {
      users.doc(globals.user_email).collection('tareas').doc('tarea0').set({
        'nombre_tarea': 'tarea0',
        'hora_inicio': '',
        'hora_fin': '',
        'repeticiones': '',
        'modificable' : 'si',
        'hecho': 'falso',
        'days': '[, , , , , , , ]'
      }).then((_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.of(context).pushReplacementNamed('/maintabs');
        ShowInfo().showDismissableFlushbar(context, '  Usuario añadido  ');
      });
    }
    ).catchError((error) => print("Failed to add user: $error"));

  }



  addSupervisor(context) {
      users.doc(globals.user_email).set({
        'fullname': globals.nombre_persona,
        'email': globals.user_email,
        'rol': globals.user_rol,
        'supervisado': ''
      }).then((_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //Navigator.of(context).pushReplacementNamed('/maintabs');
        Navigator.pushNamed(context, '/maintabs');
        ShowInfo().showDismissableFlushbar(context, '  Nuevo usuario creado  ');
      })
          .catchError((error) => print("Failed to add user: $error"));
  }

  comprobarSupervisado(String correo, bool hay)  async {
    print(correo);
    var there = await FirebaseFirestore.instance.collection('usuarios').doc(correo).get();
    if(there.exists) {
      hay = true;

    } else {
      hay = false;
    }
  }

  Future<void> registerToFb(TextEditingController emailController, TextEditingController nameController,
      TextEditingController passwordController,BuildContext context, String rol) async {
    globals.user_email = emailController.text;
    globals.nombre_persona = nameController.text;

      firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
          .then((result) {
        (rol == 'supervisado')
            ? addSupervisado(context)
            : addSupervisor(context);

        if (rol == 'supervisado') {
          tablaUsuarios.Competir(nameController.text, emailController.text, 0);
        }
      }).catchError((err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(err.message),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
  }

  changeSupervisado(TextEditingController emailController, BuildContext context)  {
    users.doc(globals.user_email).update({'supervisado': emailController.text})
        .then((_) {
        ShowInfo().showDismissableFlushbar(context, '  Cambio supervisado  ');
          Navigator.pop(context);
        })
        .catchError((error) => print("Failed to change user: $error"));

    globals.email_supervision = emailController.text;
  }


}
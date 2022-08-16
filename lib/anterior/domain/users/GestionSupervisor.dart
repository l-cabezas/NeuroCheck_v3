/*
import 'package:NeuroCheck/domain/notification/SendNotification.dart';
import 'package:NeuroCheck/domain/notification/notification_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/Strings.dart';

class GestionSupervisor{
  //inicializacion
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SendNotificacion sendNotificacion = SendNotificacion();

  var users = FirebaseFirestore.instance.collection("usuarios");

//.collection("tareas");
  getSupervisado(String user_email) async {
    await FirebaseFirestore.instance.collection("usuarios").doc(user_email)
        .get().asStream()
        .forEach((element) {
          email_supervision = element['supervisado'];
        });
  }

  updateDoneTarea(BuildContext context, String check, String nombretarea,) async {
    var data = await users.doc(email_supervision).collection('tareas').doc(nombretarea);
    data.update({'hecho': check,}).then((_) => showMessage(context,'Bien hecho!'))
        .catchError((error) => print("Failed to mod tarea: $error"));
  }

  modHoraIniTarea(BuildContext context,String nombreT,String horaIni){
    hora_inicio=horaIni;
    var data = users.doc(email_supervision).collection('tareas').doc(nombreT);
    data.update({'hora_inicio': horaIni})
        .then((value) => showMessage(context, 'Hora inicio modificada'))
        .catchError(showMessage(context, 'Error no modificado'));
    sendNotificacion.removeNotification(nombreT);
    sendNotificacion.notificarUNAtarea(context, nombreT);
  }

  modHoraFinTarea(BuildContext context,String nombreT,String horaFin){
    hora_fin=horaFin;
    var data = users.doc(email_supervision).collection('tareas').doc(nombreT);
    data.update({'hora_fin': horaFin})
        .then((value) => showMessage(context, 'Hora fin modificada'))
        .catchError(showMessage(context, 'Error no modificado'));
    sendNotificacion.removeNotification(nombreT);
    sendNotificacion.notificarUNAtarea(context, nombreT);
  }

  modNombreTarea(BuildContext context,String nombreT){
    var data = users.doc(email_supervision).collection('tareas').doc(nombreT);
    data.update({'nombre_tarea': nombreT})
        .then((value) => showMessage(context, 'Nombre tarea modificado'))
        .catchError(showMessage(context, 'Error no modificado'));
  }

  modRepeticionesTarea(BuildContext context,String nombreT,String repe){
    repeticiones = repe;
    var data = users.doc(email_supervision).collection('tareas').doc(nombreT);
    data.update({'repeticiones': repe})
        .then((value) => showMessage(context, 'Número repeticiones modificado'))
        .catchError(showMessage(context, 'Error no modificado'));
    sendNotificacion.removeNotification(nombreT);
    sendNotificacion.notificarUNAtarea(context, nombreT);
  }
  addTarea(BuildContext context,String horaInicio, String horaFinal, String repe) {
      var data = users.doc(user_email).collection('tareas');
      data.doc('cambiar').set({
        'nombre_tarea': 'cambiar',
        'hora_inicio': horaInicio,
        'hora_fin': horaFinal,
        'repeticiones': repe,
        'modificable' : 'no',
        'hecho': 'false'
      }).then((_) => showMessage(context, 'Tarea añadida'))
          .catchError((error) => print("Failed to add user: $error"));
  }

  showMessage(BuildContext context, String mensaje){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Color(0xff8ba5ff),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(50),
            elevation: 30,
            dismissDirection: DismissDirection.vertical,
            duration: Duration(seconds: 3),
            content: Text(mensaje)
        )
    );
  }
}*/

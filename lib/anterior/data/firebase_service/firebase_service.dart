import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:neurocheck/device/shared_preferences/shared_preferences.dart';

import '../models/userApp_entity.dart';

class FirebaseService extends ChangeNotifier {

  String v = '';

  String uid = '';
  String uidSupervised = '';
  String rol = '';

  var users = FirebaseFirestore.instance.collection("usuarios");

  //añadir supervisado

  initSharedPreferences() async {
     uid = (await SharedPreferencesDatos().getUID_userToSF())!;
     uidSupervised = (await SharedPreferencesDatos().getUID_SupervisedToSF())!;
     rol = (await SharedPreferencesDatos().getRolToSF())!;
  }


  addSupervised(UserApp userApp){{
    users.doc(userApp.uid).set({
      'uid': userApp.uid,
      'fullname': userApp.nombre,
      'email': userApp.email,
      'rol': userApp.rol,
    }).then((_) {
      //inicializamos sus datos con una tarea vacía
      users.doc(userApp.uid).collection('tareas').doc('tarea0').set({
        'nombre_tarea': 'tarea0',
        'hora_inicio': '',
        'hora_fin': '',
        'repeticiones': '',
        'modificable' : 'si',
        'hecho': 'falso',
        'days': '[, , , , , , , ]'
      });
    }
    ).catchError((error) => print("Failed to add user: $error"));
  }
  }

  //añadir supervisor

  addBoss(UserApp userApp) {
    users.doc(uid).set({
      'fullname': userApp.nombre,
      'email': userApp.nombre,
      'rol': rol,
      'supervisado': uidSupervised
    }).catchError((error) => print("Failed to add user: $error"));
  }

  // obtener datos usuario supervisado

  inicializarUser(String uidUser) async {
    String fullname = '';
    String email = '';
    String rol = '';
    String uidSupervised = '';
    await users.doc(uidUser).get()
        .then((value) {
      email = value.data()!['email'];
      fullname = value.data()!['fullname'];
      rol = value.data()!['rol'];
      uidSupervised = value.data()!['supervisado'];
    });

    SharedPreferencesDatos()
        .setEmailToSF(email)
        .setNameToSF(fullname)
        .setRolToSF(rol);

    if(uidSupervised != ''){
      SharedPreferencesDatos().setUID_SupervisedToSF(uidSupervised);
    }

  }

  changeSupervised(String uid, String uidSupervisado){
    users.doc(uid).update({'supervisado': uidSupervisado});
    SharedPreferencesDatos().setUID_SupervisedToSF(uidSupervisado);
  }

//------------------------------------------------------------------------
  Future<UserApp> getUser(String correo) async {
    UserApp thisUser;
    String uid = '';
    String fullname = '';
    String email = '';
    String rol = '';
    await users.doc(correo).get()
        .then((value) {
      email = value.data()!['email'];
      fullname = value.data()!['fullname'];
      rol = value.data()!['rol'];
    });
    thisUser = UserApp(uid: uid, email: email, nombre: fullname, rol: rol);
    return thisUser;
  }

  // obtener datos supervisor

  Future<UserApp> getUserBoss(String correo) async {
    UserApp thisUser;
    String uid = '';
    String fullname = '';
    String email = '';
    String rol = '';
    String supervisado = '';
    await users.doc(correo).get()
        .then((value) {
      email = value.data()!['email'];
      fullname = value.data()!['fullname'];
      rol = value.data()!['rol'];
      supervisado = value.data()!['supervisado'];
    });
    thisUser = UserApp(uid: uid, email: email, nombre: fullname, rol: rol, supervised: supervisado);
    return thisUser;
    }


  //cambiar supervisado




}
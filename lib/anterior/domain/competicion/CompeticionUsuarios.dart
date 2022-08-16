import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/domain/resources/Strings.dart';
import '/data/global_var/globals.dart' as globals;


class CompeticionUsuarios{


  //inicializacion
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var BD = FirebaseFirestore.instance.collection("usuarios");

  addPuntos(BuildContext context) {
    var users = FirebaseFirestore.instance.collection('usuarios').doc(globals.user_email);
    var conseguir = users.get();
    var puntos;
    conseguir.then((value) => puntos = value['puntos']);
    int punt = int.parse(puntos);
    punt = punt + 1;
    users.update({ 'puntos': punt.toString()}).then((_) => {})
        .catchError((error) => print("Failed to add user: $error"));
  }

  int getPuntos(BuildContext context) {
    var users = FirebaseFirestore.instance.collection('competicion').doc(globals.user_email);
    var conseguir = users.get();
    var puntos;

    conseguir.then((value) => puntos = value['puntos']);
    puntos ??= '0';
    return int.parse(puntos);
  }

  String getNombre() {
    var users = FirebaseFirestore.instance.collection('competicion').doc(globals.user_email);
    var conseguir = users.get();
    var nombre;
    conseguir.then((value) => nombre = value['nombre']);
    nombre ??= 'ninguno';
    return nombre;
  }
 //////////AMIGOS//////

  getAmigos(String correo, BuildContext context) async {
    String nombreAmigo;
    var puntosAmigo = 0;

    var there = await FirebaseFirestore.instance.collection('competicion')
        .doc(globals.user_email).collection('amigos').doc(correo).get();
    if(there.exists) {
        print('');
        showMessage(context, 'Ya sois amigos!!');
      } else {
      var exist = await FirebaseFirestore.instance.collection('competicion')
          .doc(correo)
          .get();
      if (exist.exists) {
        await FirebaseFirestore.instance.collection('competicion').doc(correo)
            .get().asStream()
            .forEach((element) {
          nombreAmigo = element['nombre'].toString();
          puntosAmigo = element['puntos'];
        });

        if (nombreAmigo != null) {
          var miBD = FirebaseFirestore.instance.collection('competicion').doc(
              globals.user_email).collection('amigos');

          miBD.doc(correo).set({'nombre': nombreAmigo, 'puntos': puntosAmigo})
              .then((value) {
            //showAddedAmigo(context, 'usuario añadido correctamente');
          })
              .catchError((error) => print("Failed to add user: $error"));
        } else {
          print('');
          showMessage(context, 'Usuario no existe');
        }
      }else{
        print('');
        //showAddedAmigo(context, 'Usuario no existe');
      }
    }
  }


  Competir(String nombre, String email,int puntos) async {
    var bd =  FirebaseFirestore.instance.collection('competicion').doc(globals.user_email).collection('amigos')
        .doc(email);
    bd.set({'nombre': email,'email': email,'puntos': puntos,});
    var datos =  FirebaseFirestore.instance.collection('competicion').doc(globals.user_email);
    datos.set({'nombre':nombre, 'puntos':puntos});
  }

  addPoint(String correo) async {
    var puntos;
    await FirebaseFirestore.instance.collection('competicion').doc(correo)
        .get().asStream()
        .forEach((element) {
      puntos = element['puntos'];
    });

    puntos=puntos+1;

    var bd = FirebaseFirestore.instance.collection('competicion').doc(globals.user_email).collection('amigos')
        .doc(correo);
    bd.update({'puntos': puntos,});
    var datos =  FirebaseFirestore.instance.collection('competicion').doc(globals.user_email);
    datos.update({'puntos':puntos});
  }

  minusPoint(String correo) async {
    var puntos;
    await FirebaseFirestore.instance.collection('competicion').doc(correo)
        .get().asStream()
        .forEach((element) {
      puntos = element['puntos'];
    });

    puntos=puntos-1;
    if(puntos<0){puntos=0;}

    var bd = FirebaseFirestore.instance.collection('competicion').doc(globals.user_email).collection('amigos')
        .doc(correo);
    bd.update({'puntos': puntos,});
    var datos =  FirebaseFirestore.instance.collection('competicion').doc(globals.user_email);
    datos.update({'puntos':puntos});
  }

  showMessage(BuildContext context, String mensaje){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: const Color(0xff8ba5ff),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(50),
            elevation: 30,
            dismissDirection: DismissDirection.vertical,
            duration: const Duration(seconds: 3),
            content: Text(mensaje)
        )
    );
  }


}
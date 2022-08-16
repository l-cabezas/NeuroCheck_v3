import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../global_var/globals.dart' as globals;


import '../models/competidor_entity.dart';
import '../models/task_entity.dart';
import '../models/userApp_entity.dart';

//-------------------------------CLOUD FIRESTORE--------------------------------

class FirestoreService extends ChangeNotifier {


  FirebaseFirestore db = FirebaseFirestore.instance;
  var uid = FirebaseAuth.instance.currentUser?.uid;
  var CORREO = FirebaseAuth.instance.currentUser?.email.toString();

  //añadir usuarios
  addSupervisado(UserApp userApp) {
    db.collection('usuarios').doc(userApp.uid).set({
      'uid': userApp.uid,
      'fullname': userApp.nombre,
      'email': userApp.email,
      'rol': userApp.rol,
    }).then((_) {
      db.collection('usuarios').doc(userApp.uid)
          .collection('tareas').doc('tarea0').set({
        'nombre_tarea': 'tarea0',
        'hora_inicio': '',
        'hora_fin': '',
        'repeticiones': '',
        'modificable' : 'si',
        'hecho': 'falso',
        'days':'',
      }).then((value) => print("User added"));})
        .catchError((error) => print("Failed to add user: $error"));
  }

  /*addSupervisor(String userEmail, String fullname, String rol) {
    db.collection('usuarios').doc(uidUser).set({
      'fullname': fullname,
      'email': userEmail,
      'rol': rol,
      'supervisado': ''
    })  .then((value) => print("User added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addUsuarioASupervisor() async{
    db.collection('usuarios').doc(uidUser).update({
      'supervisado': uidSupervised
    })  .then((value) => print("User added"))
        .catchError((error) => print("Failed to add user: $error"));
  }*/

//-------------------------------OBTENER DATOS----------------------------------

  // get todas las tareas
  Future<List<Task>> getTasksByEmail(String email) async {
    var tareas = <Task>[];
    print('email $email');
    await db.collection('usuarios').doc(email).collection('tareas').get().then((value) {
      for (var element in value.docs) {
        if(element['nombre_tarea']!= 'tarea0') {
          tareas.add(Task.fromMap(element.data()),);
        }
      }
    });
    return tareas;
  }

  Future<List<Task>> getTasks() async {
    var tareas = <Task>[];
    await db.collection('usuarios')
        //.doc(FirebaseAuth.instance.currentUser?.email.toString())
        .doc(uid)
        .collection('tareas')
        .get()
        .then((value) {
      for (var element in value.docs) {
          tareas.add(Task.fromMap(element.data()),);
      }
    });
    return tareas;
  }

  Future<String> getRol(String correo) async {
    String rol = '';
    await db.collection('usuarios').doc(correo).get()
        .then((value) {
      rol = value.data()!['rol'];
    }
    ).catchError((error) {
      rol = 'Error recuperando rol';
    });
    return rol;
  }

  Future<String> getFullName(String correo) async {
    String fullname = '';
    await db.collection('usuarios').doc(correo).get()
        .then((value) {
      fullname = value.data()!['fullname'];
    }
    ).catchError((error) {
      fullname = 'Error recuperando rol';
    });
    return fullname;
  }


  //get una tarea
  Future<Task> getOneTask(String tarea) async {
    var task = await db.collection('usuarios').doc(globals.user_email).collection('tareas').doc(tarea).get();
    return Task.fromMap(task.data()!);
  }

  List<dynamic> getIDs(String nombretarea){
    var data = db.collection('usuarios').doc(globals.user_email).collection('tareas')
        .doc(nombretarea);
    List<dynamic> ids = <dynamic> [];
    data.snapshots().forEach((element) {
      //print(element.data()?['id']);
      ids.add(element.data()?['id']);
    });
    print(ids);
    return ids;
  }

//-------------------------------MODIFICACIONES---------------------------------

  //añadir y borrar tareas
  addTask(String nombreTarea,String horaInicio,
      String horaFinal, String repe, String modificable, String days) async {
    await db.collection('usuarios').doc(uid).collection('tareas').doc(nombreTarea).set({
      'nombre_tarea': nombreTarea,
      'hora_inicio': horaInicio,
      'hora_fin': horaFinal,
      'repeticiones': repe,
      'modificable' : modificable,
      'hecho': 'false',
      'days': days

    }).then((_) => print('Tarea añadida con exito'))
        .catchError((error) => print("Failed to add task: $error"));
  }

  deleteTarea(String task) {
    var data = db.collection('usuarios').doc(globals.user_email).collection('tareas')
        .doc(task);

    data.delete()
        .then((_) => print('Tarea eliminada con exito'))
        .catchError((error) => print("Failed to delete task: $error"));

  }

  //mod hora_inicio, hora_fin, repeticiones y check

   modHechoTarea(String nombretarea,String check) {
    var data = db.collection('usuarios').doc(globals.user_email).collection('tareas')
        .doc(nombretarea);

    data.update({'hecho':check})
        .then((_) => print('Tarea checkeada con exito'))
        .catchError((error) => print("Failed to check task: $error"));

  }

   modRepeticionesTarea(String nombreT,String repe){
     globals.repeticiones = repe;
    var data = db.collection('usuarios').doc(globals.user_email).collection('tareas').doc(nombreT);
    data.update({'repeticiones': repe})
        .then((value) => print( 'Número repeticiones modificado'))
        .catchError((error) =>print( 'Error no modificado'));
  }

   modHoraIniTarea(String nombreT,String horaIni){
    var data = db.collection('usuarios').doc(globals.user_email).collection('tareas').doc(nombreT);
    data.update({'hora_inicio': horaIni})
        .then((value) => print( 'Número repeticiones modificado'))
        .catchError((error) =>print( 'Hora modificado'));
  }

   modHoraFinTarea(String nombreT,String horaFin){
    var data = db.collection('usuarios').doc(globals.user_email).collection('tareas').doc(nombreT);
    data.update({'hora_fin': horaFin}).then((value) => print( 'Hora modificado'))
        .catchError((error) =>print( 'Error no modificado'));

  }

  modDays(String nombreT,String days){
    var data = db.collection('usuarios').doc(globals.user_email).collection('tareas').doc(nombreT);
    data.update({'days': days}).then((value) => print( 'Días modificados'))
        .catchError((error) =>print( 'Error no modificado'));

  }

   modId(String nombreT,List<dynamic> id){
    var data = db.collection('usuarios').doc(globals.user_email).collection('tareas').doc(nombreT);
    data.update({'id': id}).then((value) => print( 'Hora modificado'))
        .catchError((error) =>print( 'Error no modificado'));

  }

  modDias(String nombreT,String days){
    var data = db.collection('usuarios').doc(globals.user_email).collection('tareas').doc(nombreT);
    data.update({'days': days}).then((value) => print( 'Días modificado'))
        .catchError((error) =>print( 'Error no modificado'));

  }

  cambiarSupervisado(String email)  {
    print(globals.user_supervisor_email);
    db.collection('usuarios').doc(globals.user_supervisor_email).update({'supervisado': email})
        .then((value) => print("Supervisor cambiado"))
        .catchError((error) => print("Failed to change user: $error"));
  }


//-----------------------------SOLO SUPERVISADO-------------------------------------------
  // --------------------------COMPETICION PUNTOS-----------------------------
  Future<int> getPuntos() async {
    var competicion = await db.collection('competicion').doc(globals.user_email).get();
     var puntos = competicion.data()!['puntos'];
    return puntos;
  }

  addPuntos() async {
    var puntos;
    await FirebaseFirestore.instance.collection('competicion').doc(globals.user_email)
        .get().asStream()
        .forEach((element) {
      puntos = element['puntos'];
    });

    puntos=puntos+1;

    var bd = FirebaseFirestore.instance.collection('competicion').doc(globals.user_email).collection('amigos')
        .doc(globals.user_email);
    bd.update({'puntos': puntos,});
    var datos =  FirebaseFirestore.instance.collection('competicion').doc(globals.user_email);
    datos.update({'puntos':puntos});
  }

  quitarPuntos() async {
    var puntos;
    await FirebaseFirestore.instance.collection('competicion').doc(globals.user_email)
        .get().asStream()
        .forEach((element) {
      puntos = element['puntos'];
    });

    puntos=puntos-1;
    if(puntos<0){puntos=0;}

    var bd = db.collection('competicion').doc(globals.user_email).collection('amigos')
        .doc(globals.user_email);
    bd.update({'puntos': puntos,});
    var datos =  db.collection('competicion').doc(globals.user_email);
    datos.update({'puntos':puntos});
  }

  Future<List<Competidor>> showDatosCompeticion() async {
    var competidores = <Competidor> [];
    await db.collection('competicion')
        .doc(globals.user_email)
        .collection('amigos')
        .orderBy('puntos', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        competidores.add(Competidor.fromMap(element.data()),);
      }
    });
    return competidores;
  }

  competir(String nombre, String email,int puntos) async {
    var baseDatos =  db.collection('competicion')
        .doc(globals.user_email)
        .collection('amigos')
        .doc(email);
    baseDatos.set({'nombre': email,'email': email,'puntos': puntos,});
    var datos =  FirebaseFirestore.instance.collection('competicion').doc(globals.user_email);
    datos.set({'nombre':nombre, 'puntos':puntos});
  }

  getAmigos(String correo) async {
    String nombreAmigo;
    var puntosAmigo = 0;

    var there = await db.collection('competicion')
        .doc(globals.user_email).collection('amigos').doc(correo).get();
    if(there.exists) {
      print('Ya sois amigos!!');
    } else {
      var exist = await FirebaseFirestore.instance.collection('competicion')
          .doc(correo)
          .get();
      if (exist.exists) {
        await db.collection('competicion').doc(correo)
            .get().asStream()
            .forEach((element) {
          nombreAmigo = element['nombre'].toString();
          puntosAmigo = element['puntos'];
        });

        if (nombreAmigo != null) {
          var miBD = db.collection('competicion').doc(
              globals.user_email).collection('amigos');

          miBD.doc(correo).set({'nombre': nombreAmigo, 'puntos': puntosAmigo})
              .then((value) {
            //showAddedAmigo(context, 'usuario añadido correctamente');
          })
              .catchError((error) => print("Failed to add user: $error"));
        } else {
          print('Usuario no existe');
        }
      }else{
        print('');
        //showAddedAmigo(context, 'Usuario no existe');
      }
    }
  }



}
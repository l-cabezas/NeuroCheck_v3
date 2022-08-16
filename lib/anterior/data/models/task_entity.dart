import 'dart:convert';


import 'package:cloud_firestore/cloud_firestore.dart';
import '../global_var/globals.dart' as globals;

Task taskFromMap(String str) => Task.fromMap(json.decode(str));

String taskToMap(Task data) => json.encode(data.toMap());

class Task {
  String nombre_tarea;
  String hora_inicio;
  String hora_fin;
  List<dynamic>? id;
  String modificable;
  String hecho;
  String repeticiones;
  String days;

  Task({
    required this.nombre_tarea,
    required this.hora_inicio,
    required this.hora_fin,
    this.id,
    required this.modificable,
    required this.hecho,
    required this.repeticiones,
    required this.days,
  });



  factory Task.fromMap(Map<String, dynamic> json) => Task(
    nombre_tarea: json['nombre_tarea'],
    hora_inicio: json['hora_inicio'],
    hora_fin: json['hora_fin'],
    id: json['id'],
    modificable: json['modificable'],
    hecho: json['hecho'],
    repeticiones: json['repeticiones'],
    days: json['days'],
  );

  Map<String, dynamic> toMap() => {
    'nombre_tarea' : nombre_tarea,
    'hora_inicio' : hora_inicio,
    'hora_fin': hora_fin,
    'id': id,
    'modificable': modificable,
    'hecho': hecho,
    'repeticiones': repeticiones,
    'days': days,
  };

  factory Task.fromFirestore(DocumentSnapshot documentSnapshot) {
    var task = Task.fromMap(documentSnapshot.get(globals.user_email));
    return task;
  }
}

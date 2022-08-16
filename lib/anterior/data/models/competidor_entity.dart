import 'dart:convert';


import 'package:cloud_firestore/cloud_firestore.dart';
import '../global_var/globals.dart' as globals;

Competidor competidorFromMap(String str) => Competidor.fromMap(json.decode(str));

String competidorToMap(Competidor data) => json.encode(data.toMap());

class Competidor {
  String uid;
  String nombre;
  String email;
  int puntos;


  Competidor({
    required this.uid,
    required this.nombre,
    required this.email,
    required this.puntos,
  });



  factory Competidor.fromMap(Map<String, dynamic> json) => Competidor(
    uid: json['uid'],
    nombre: json['nombre'],
    email: json['email'],
    puntos: json['puntos'],
  );

  Map<String, dynamic> toMap() => {
    'nombre' : nombre,
    'email' : email,
    'puntos': puntos,
  };

  factory Competidor.fromFirestore(DocumentSnapshot documentSnapshot) {
    var competidor = Competidor.fromMap(documentSnapshot.get(globals.user_email));
    return competidor;
  }
}

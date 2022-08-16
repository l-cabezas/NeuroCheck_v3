import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {
  String uid;
  String email;
  String nombre;
  String rol;
  String? supervised;

  UserApp({
    required this.uid,
    required this.email,
    required this.nombre,
    required this.rol,
    this.supervised
  });


  UserApp taskFromMap(String str) => UserApp.fromMap(json.decode(str));

  String taskToMap(UserApp data) => json.encode(data.toMap());


  factory UserApp.fromMap(Map<String, dynamic> json) => UserApp(
    uid: json['uid'],
    email: json['email'],
    nombre: json['fullname'],
    rol: json['rol'],
    supervised: json['supervisado'],
  );

  Map<String, dynamic> toMap() => {
    'uid':  uid,
    'email' : email,
    'fullname' : nombre,
    'rol': rol,
    'supervisado': supervised,

  };

  factory UserApp.fromFirestore(DocumentSnapshot documentSnapshot, UserApp userApp) {
    var userApp = UserApp.fromMap(documentSnapshot.get(userApp.uid));
    return userApp;
  }


}

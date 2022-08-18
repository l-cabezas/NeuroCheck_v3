import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uId;
  final String email;
  final String? name;
  //final String? phone;
  final String? rol;
  final String? image;

  UserModel({
    required this.uId,
    required this.email,
    this.name,
   // required this.phone,
    this.rol,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'email': email,
      'name': name ?? '',
      //'phone': phone ?? '',
      'rol': rol ?? '',
      'image': image ?? '',
    }..removeWhere((key, value) => value == null);
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      uId: documentId,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      //phone: map['phone'] ?? '',
      rol: map['rol'] ?? '',
      image: map['image'] ?? '',
    );
  }

  /// Google Factory
  factory UserModel.fromUserCredential(User user, String? rol, String? name) {
    log('llegó2');
    return UserModel(
      uId: user.uid,
      email: user.email ?? '',
      name: name ?? user.displayName?.split(' ').first, //?? '',
      //phone: user.phoneNumber ?? '',
      rol: rol ?? '',
      image: user.photoURL ?? '',
    );
  }

  UserModel copyWith({
    String? uId,
    String? name,
    String? email,
    String? rol,
    String? image,
    String? phone,
  }) {
    return UserModel(
      uId: uId ?? this.uId,
      name: name ?? this.name,
      email: email ?? this.email,
      rol: rol ?? this.rol,
      image: image ?? this.image,
      //phone: phone ?? this.phone,
    );
  }
}

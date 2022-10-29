import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uId;
  final String email;
  final String? name;
  //final String? phone;
  final String? rol;
  final String? uidSupervised;
  final String? image;

  UserModel({
    required this.uId,
    required this.email,
    this.name,
   // required this.phone,
    this.rol,
    this.uidSupervised,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'email': email,
      'name': name ?? '',
      //'phone': phone ?? '',
      'rol': rol ?? '',
      'uidSupervised': uidSupervised ?? '',
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
      uidSupervised: map['uidSupervised'] ?? '',
      image: map['image'] ?? '',
    );
  }

  /// Google Factory
  factory UserModel.fromUserCredential(User user, String? rol, String? name, String? uidSupervised) {
    return UserModel(
      uId: user.uid,
      email: user.email ?? '',
      name: name ?? user.displayName?.split(' ').first, //?? '',
      //phone: user.phoneNumber ?? '',
      rol: rol ?? '',
      uidSupervised: uidSupervised ?? '',
      image: user.photoURL ?? '',
    );
  }

  factory UserModel.setSupervised(User user, String? rol, String? name, String? uidSupervised) {
    return UserModel(
      uId: user.uid,
      email: user.email ?? '',
      name: name ?? user.displayName?.split(' ').first, //?? '',
      //phone: user.phoneNumber ?? '',
      rol: rol ?? '',
      uidSupervised: uidSupervised ?? '',
      image: user.photoURL ?? '',
    );
  }

  UserModel copyWith({
    String? uId,
    String? name,
    String? email,
    String? rol,
    String? uidSupervised,
    String? image,
    String? phone,
  }) {
    return UserModel(
      uId: uId ?? this.uId,
      name: name ?? this.name,
      email: email ?? this.email,
      rol: rol ?? this.rol,
      uidSupervised: uidSupervised ?? this.uidSupervised,
      image: image ?? this.image,
      //phone: phone ?? this.phone,
    );
  }
}

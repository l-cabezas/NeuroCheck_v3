import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neurocheck/data/firebase_service/firebase_service.dart';
import 'package:neurocheck/data/models/userApp_entity.dart';
import '/data/global_var/globals.dart' as globals;

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{


  final FirebaseService _userFirestoreService;

  AuthRepositoryImpl(this._userFirestoreService)
      : assert(_userFirestoreService != null);

  //inicializacion
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var users = FirebaseFirestore.instance.collection("usuarios");


  @override
  addSupervised(UserApp userApp) async{
    await _userFirestoreService.addSupervised(userApp);
  }

  @override
  addBoss(UserApp userApp) async {
    await _userFirestoreService.addBoss(userApp);
  }

  @override
  changeSupervised(String uid, String uidSupervisado) async {
    await _userFirestoreService.changeSupervised(uid, uidSupervisado);
  }

  @override
  inicializarUser(String uidUser) async {
    await _userFirestoreService.inicializarUser(uidUser);
  }



}

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neurocheck/auth/repos/user_repo.dart';
import 'package:neurocheck/auth/viewmodels/auth_state.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../models/user_model.dart';

final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepo());

class AuthRepo {
  const AuthRepo();
  //registro y login
  //createUserWithEmailAndPassword
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log(userCredential.toString());
      //MOD
      GetStorage().write('uidUsuario', userCredential.user?.uid);
      GetStorage().write('email', email);
      GetStorage().write('passw', password);
      return Right(UserModel.fromUserCredential(userCredential.user!,'','','',''));

    } on FirebaseAuthException catch (e) {
      final errorMessage = Exceptions.firebaseAuthErrorMessage(context, e);
      return Left(ServerFailure(message: errorMessage));

    } catch (e) {
      log(e.toString());
      final errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: errorMessage));
    }
  }

  Future<Either<Failure, UserModel>> signSupervisedIn(
      BuildContext context, {
        required String emailSupervised,
        required String passwordSupervised,
      }) async {
    try {
      //iniciamos sesion con el user del supervisado para conseguir su uid

      GetStorage().write('emailSup', emailSupervised);
      GetStorage().write('passwSup', passwordSupervised);

      final userCredentialSupervised = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailSupervised,
          password: passwordSupervised);

      GetStorage().write('uidSup', userCredentialSupervised.user!.uid);
      //var uidSupervised = userCredentialSupervised.user!.uid;
      log('supervised: ' + GetStorage().read('uidSup'));
      try{
        //cerramos sesión e iniciamos sesión con nuestra cuenta
        await FirebaseAuth.instance.signOut();

        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: GetStorage().read('email'), password: GetStorage().read('passw'));


        //User user, String? rol, String? name, String? uidSupervised
        return Right(
            UserModel.fromUserCredential(userCredential.user!,'supervised','' ,GetStorage().read('uidSup')
                ,GetStorage().read('emailSup')
            )
        );

      }on FirebaseAuthException catch (e) {
        final errorMessage = Exceptions.firebaseAuthErrorMessage(context, e);
        return Left(ServerFailure(message: errorMessage));

      } catch (e) {
        log(e.toString());
        final errorMessage = Exceptions.errorMessage(e);
        return Left(ServerFailure(message: errorMessage));
      }

    } on FirebaseAuthException catch (e) {
      final errorMessage = Exceptions.firebaseAuthErrorMessage(context, e);
      return Left(ServerFailure(message: errorMessage));

    } catch (e) {
      log(e.toString());
      final errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: errorMessage));
    }
  }

  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword(
      BuildContext context, {
        required String email,
        required String password,
        required String name,
        required String rol,
      }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      log(userCredential.toString());
      GetStorage().write('uidUsuario', userCredential.user?.uid);
      GetStorage().write('email', email);
      GetStorage().write('passw', password);
      GetStorage().write('rol', rol);

      return Right(UserModel.fromUserCredential(userCredential.user!,rol, name,'',''));
    } on FirebaseAuthException catch (e) {
      final errorMessage = Exceptions.firebaseAuthErrorMessage(context, e);
      return Left(ServerFailure(message: errorMessage));

    } catch (e) {
      log(e.toString());
      final errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: errorMessage));
    }
  }

  //auth.sendPasswordResetEmail(email: logic.emailController.text.trim());

  Future<Either<Failure, bool>> sendPasswordResetEmail(
      BuildContext context, {
        required String email,
      }) async {
    try {
       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
       return const Right(true);
    } on FirebaseAuthException catch (e) {
      final errorMessage = Exceptions.firebaseAuthErrorMessage(context, e);
      return Left(ServerFailure(message: errorMessage));
    } catch (e) {
      log(e.toString());
      final errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: errorMessage));
    }
  }


  isVerifiedEmail() async {
    return await FirebaseAuth.instance.currentUser!.reload();
  }

  deleteUser() async {
     await FirebaseAuth.instance.currentUser!.delete();
  }

  Stream<bool?> isEmailverified() async* {
    bool? enabled;
    while (true) {
      try {
        await FirebaseAuth.instance.currentUser!.reload();
        bool? isEnabled = FirebaseAuth.instance.currentUser?.emailVerified;
        if (enabled != isEnabled) {
          enabled = isEnabled;
          yield enabled;
        }
      }
      catch (error) {}
      await Future.delayed(Duration(seconds: 5));
    }
  }

  Future<Either<Failure, bool>> sendEmailVerification(
      BuildContext context,) async {
    try {
      AuthState.loading();
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      final errorMessage = Exceptions.firebaseAuthErrorMessage(context, e);
      return Left(ServerFailure(message: errorMessage));
    } catch (e) {
      log(e.toString());
      final errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: errorMessage));
    }
  }






  //cerrar sesion
  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

}

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../models/user_model.dart';

final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepo());

class AuthRepo {
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
      return Right(UserModel.fromUserCredential(userCredential.user!,'','',''));
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
        required String email,
        required String password,
        required String emailSupervised,
        required String passwordSupervised,
      }) async {
    try {
      //iniciamos sesion con el user del supervisado para conseguir su uid
      final userCredentialSupervised = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailSupervised,
          password: passwordSupervised);
      var uidSupervised = userCredentialSupervised.user!.uid;
      log('supervised: ' + uidSupervised);
      try{
        //cerramos sesión e iniciamos sesión con nuestra cuenta
        await FirebaseAuth.instance.signOut();

        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        log('userCredential: ' + userCredential.toString());
        log('supervised2: ' + uidSupervised);

        //User user, String? rol, String? name, String? uidSupervised
        return Right(UserModel.fromUserCredential(userCredential.user!,'supervised','' ,uidSupervised));

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

      return Right(UserModel.fromUserCredential(userCredential.user!,rol, name,''));
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
    return await FirebaseAuth.instance.currentUser!.reload();;
  }

  Future<Either<Failure, bool>> sendEmailVerification(
      BuildContext context,) async {
    try {
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

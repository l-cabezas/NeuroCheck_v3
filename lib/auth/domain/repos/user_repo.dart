import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/data/error/failures.dart';
import '../../../core/presentation/services/firebase_services/firebase_caller.dart';
import '../../../core/presentation/services/firebase_services/firestore_paths.dart';
import '../../../core/presentation/services/firebase_services/i_firebase_caller.dart';
import '../../data/models/user_model.dart';

//manejar datos de usuario

final userRepoProvider = Provider<UserRepo>((ref) => UserRepo(ref));

class UserRepo {
  UserRepo(this.ref) {
    _firebaseCaller = ref.watch(firebaseCaller);
  }


  final Ref ref;
  late IFirebaseCaller _firebaseCaller;

  /*String? uid;
  String? uidSuper;*/
  UserModel? userModel;
  var user = FirebaseAuth.instance.currentUser?.uid;

  Future<Either<Failure, UserModel?>> getUserData(String userId) async {
    return await _firebaseCaller.getData(
      path: FirestorePaths.userDocument(userId),
      builder: (data, docId) {
        if (data is! ServerFailure) {
          userModel = data != null ? UserModel.fromMap(data, docId!) : null;
         /* uid = userModel?.uId;
          uidSuper = userModel?.uidSupervised;*/
          //addStringToSFRol(userModel?.rol);
          GetStorage().write('rol', userModel?.rol);
          GetStorage().write('uidUsuario', userModel?.uId);
          GetStorage().write('uidSup', userModel?.uidSupervised);
          //Other way to 'extract' the data
          return Right(userModel);
        } else {
          return Left(data);
        }
      },
    );
  }
   deleteUserRepo(UserModel userData) async {
    await _firebaseCaller.deleteAllCollectionData(
      path: FirestorePaths.userUId(userData.uId),
    );
  }


/*  Future<Either<Failure, bool>> deleteUserAuth(
      BuildContext context, {
        required String email,
      }) async {
    try {
      final userCredentialSupervised = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: GetStorage().read('emailSup'),
          password:  GetStorage().read('passwSup'));

      await deleteUserRepo(GetStorage().read('uidSup'));
      await userCredentialSupervised.user?.delete();
      GetStorage().write('emailSup', '');
      GetStorage().write('passwSup', '');
      GetStorage().write('uidSup', '');

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: GetStorage().read('email'),
          password:  GetStorage().read('passw'));

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      final errorMessage = Exceptions.firebaseAuthErrorMessage(context, e);
      return Left(ServerFailure(message: errorMessage));
    } catch (e) {
      log(e.toString());
      final errorMessage = Exceptions.errorMessage(e);
      return Left(ServerFailure(message: errorMessage));
    }
  }*/


 //------------------------------------------------------------------------------
  Future<Either<Failure, UserModel?>> checkUidSup() async {
    return await _firebaseCaller.getData(
      path: FirestorePaths.userDocument(user!),
      builder: (data, docId) {
        if (data is! ServerFailure) {
          userModel = data != null ? UserModel.fromMap(data, docId!) : null;
          /*uid = userModel?.uId;
          uidSuper = userModel?.uidSupervised;*/
          //Other way to 'extract' the data
          return Right(userModel);
        } else {
          return Left(data);
        }
      },
    );
  }

  Future<String?> getUidSup() async {
    return await _firebaseCaller.getData(
      path: FirestorePaths.userDocument(user!),
      builder: (data, docId) {
          userModel = data != null ? UserModel.fromMap(data, docId!) : null;
          /*uid = userModel?.uId;
          uidSuper = userModel?.uidSupervised;*/
          //Other way to 'extract' the data
        return userModel?.uidSupervised;
      },
    );
  }
  // guardamos los datos del usuario en firebase
  Future<Either<Failure, bool>> setUserData(UserModel userData) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(userData.uId),
      data: userData.toMap(),
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          userModel = userData;
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  registerUserData(UserModel userData) async {
     await _firebaseCaller.addDataToCollection(
      path: FirestorePaths.userDocument(userData.uId),
      data: userData.toMap(),
    );
  }

  //creamos una tarea incial que luego se descarta para inicializar
  // la bd de firebase
  /*openCollection(UserModel userData) async {
    TaskModel tarea0 = TaskModel(
      taskId: 'tarea0',
      taskName: 'tarea0',
      begin : '',
      end: '',
      editable: '',
      days: [],
      notiHours: [],
      idNotification: [],
      done : '',
      numRepetition: 0,
      lastUpdate: Timestamp.fromDate(DateTime.now()),
      isNotificationSet: '',
    );
    await _firebaseCaller.addDataToCollection(
      path: FirestorePaths.getTaskCollection(userData.uId),
      data: tarea0.toMap(),
    );
  }*/
// se updatea el usuario en firebase
  Future<Either<Failure, bool>> updateUserData(UserModel userData) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(GetStorage().read('uidUsuario')),
      data: userData.toMap(),
      merge: true,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          userModel = userData;
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  Future<Either<Failure, bool>> updateUserImage(File? imageFile) async {
    Either<Failure, String> result = await _firebaseCaller.uploadImage(
      path: FirestorePaths.profilesImagesPath(GetStorage().read('uidUsuario')),
      file: imageFile!,
      builder: (data) {
        if (data is! ServerFailure) {
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
    return result.fold(
          (failure) {
        return Left(failure);
      },
          (imageUrl) async {
        return await setUserImage(imageUrl);
      },
    );
  }

  Future<Either<Failure, bool>> setUserImage(String imageUrl) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(GetStorage().read('uidUsuario')),
      data: {"image": imageUrl},
      merge: true,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          userModel = userModel!.copyWith(image: imageUrl);
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  deleteSupUid(String uid) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.userUId(uid),
      data: {
        "uidSupervised": ''
      },
      merge: true,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          //userModel = userModel!.copyWith(uidSupervised: user.uidSupervised);
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  deleteUidBD(String uid) async {
    log('**** DELETE UID ${uid}');
    return await _firebaseCaller.deleteData(
      path: FirestorePaths.userUId(uid),
    );
  }

  setSupervisedUid(UserModel user) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.userUId(user.uId),
      data: {
        "rol": 'supervisor',
        "uidSupervised": user.uidSupervised,
        "emailSup" : user.emailSup
      },
      merge: true,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          userModel = userModel!.copyWith(uidSupervised: user.uidSupervised);
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  Future clearUserLocalData() async {
    //uid = null;
    //userModel = null;
    GetStorage().write('uidUsuario', '');
    GetStorage().write('email', '');
    GetStorage().write('passw', '');
    GetStorage().write('rol', '');
    GetStorage().erase();
  }
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/errors/failures.dart';
import '../../core/services/firebase_services/firebase_caller.dart';
import '../../core/services/firebase_services/firestore_paths.dart';
import '../../core/services/firebase_services/i_firebase_caller.dart';
import '../../modules/tasks/models/task_model.dart';
import '../models/user_model.dart';

//manejar datos de usuario

final userRepoProvider = Provider<UserRepo>((ref) => UserRepo(ref));

class UserRepo {
  UserRepo(this.ref) {
    _firebaseCaller = ref.watch(firebaseCaller);
  }

  final Ref ref;
  late IFirebaseCaller _firebaseCaller;

  String? uid;
  UserModel? userModel;

  //extension EitherX<L, R> on Either<L, R> {
  //   R asRight() => (this as Right).value; //
  //   L asLeft() => (this as Left).value;
  // }

  Future<Either<Failure, UserModel?>> getUserData(String userId) async {
    return await _firebaseCaller.getData(
      path: FirestorePaths.userDocument(userId),
      builder: (data, docId) {
        if (data is! ServerFailure) {
          userModel = data != null ? UserModel.fromMap(data, docId!) : null;
          uid = userModel?.uId;
          //Other way to 'extract' the data
          return Right(userModel);
        } else {
          return Left(data);
        }
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
  openCollection(UserModel userData) async {
    TaskModel tarea0 = TaskModel(
      taskId: 'tarea0',
      taskName: 'tarea0',
      begin : '',
      end: '',
      editable: '',
      done : '',
      numRepetition: '',
    );
    await _firebaseCaller.addDataToCollection(
      path: FirestorePaths.getTaskCollection(userData.uId),
      data: tarea0.toMap(),
    );
  }

  Future<Either<Failure, bool>> updateUserData(UserModel userData) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.userDocument(uid!),
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
      path: FirestorePaths.profilesImagesPath(uid!),
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
      path: FirestorePaths.userDocument(uid!),
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

  setSupervisedUid(UserModel user, String rol) async {
    return await _firebaseCaller.setData(
      path: FirestorePaths.userUId(user.uId),
      data: {
        "rol": 'boss',
        "SupervisedUid": rol},
      merge: true,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          userModel = userModel!.copyWith(rol: rol);
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  Future clearUserLocalData() async {
    uid = null;
    userModel = null;
  }
}

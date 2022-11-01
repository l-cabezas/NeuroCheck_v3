/*

import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neurocheck/auth/viewmodels/auth_provider.dart';
import 'package:neurocheck/core/services/init_services/awesome_notification.dart';
import 'package:neurocheck/modules/tasks/repos/utilities.dart';
import 'package:path/path.dart';

import '../../../auth/models/user_model.dart';
import '../../../auth/repos/user_repo.dart';
import '../../../core/errors/failures.dart';
import '../../../core/services/firebase_services/firebase_caller.dart';
import '../../../core/services/firebase_services/firestore_paths.dart';
import '../../../core/services/firebase_services/i_firebase_caller.dart';
import '../../simple_notifications/notifications.dart';
import '../models/task_model.dart';

//manejar datos de tasks

final tasksRepoProvider = Provider<TasksRepo>((ref) => TasksRepo(ref));

class TasksRepo {
  TasksRepo(this.ref) {
    _userRepo = ref.watch(userRepoProvider);
    _firebaseCaller = ref.watch(firebaseCaller);
  }

  final Ref ref;
  late UserRepo _userRepo;
  late IFirebaseCaller _firebaseCaller;
  TaskModel? taskModel;

  var user = FirebaseAuth.instance.currentUser?.uid;

  // OBTECIÓN DE DATOS ---------------------------------------------------------






  UserModel? returnUsuario() {
    UserModel? user;
    getUsuario().then((value) => user = value);
    return user;
  }

  Future<UserModel?> getUsuario() async {
    final result = await _userRepo.getUserData(user!);
    return result.fold(
          (failure) {
        return null;
      },
          (userModel) {
        return userModel;
      },
    );
  }

  //obtenemos la informacion de nuestro supervisado mediante su uid
  Future<UserModel?> getInfoSupervisado(String uid) async {
    final result = await _userRepo.getUserData(uid);
    return result.fold(
          (failure) {
        return null;
      },
          (userModel) {
        return userModel;
      },
    );
  }

  Future<Either<Failure, UserModel>> getUser() async {
    final result = await _userRepo.getUserData(user!);
    return result.fold(
          (failure) {
        return Left(failure);
      },
          (userModel) {
        return Right(userModel!);
      },
    );
  }

  // MODIFICAR ELIMINAR COSAS --------------------------------------------------

  Future<Either<Failure, bool>> checkTask({required TaskModel task}) async {
    return await _firebaseCaller.updateData(
      path: FirestorePaths.taskById(user!, taskId: task.taskId),
      data: {
        'done': 'true',
      },
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }

  Future<Either<Failure, bool>> cancelTodayNotifications(
      {required TaskModel task}) async {
    var now = DateTime
        .now()
        .weekday;
    //si nos quedan ids de notificacion o no
    //if(task.idNotification?.length != 0) {
    //numero de ids que tenemos que borrar
    var numDelete = task.notiHours?.length;
    //borramos desde el primero hasta el numero de ids que correspondan a ese día
    Iterable? idCancel = task.idNotification;

    //cancelamos esas notificaciones
    idCancel?.forEach((element) {
      cancelScheduledNotification(element);
    });


    List<int> ids = [];

    //quitamos el día que hemos hecho
    List? taskMinusDay = task.days;

    //si estamos en ultimo día de rep de esa semana
    if (taskMinusDay?.length == 1) {
      //notificaciones de 0
      await makesNewNotification(task.days!, task.notiHours!)
          .then((value) => ids = value
      );
    } else {
      taskMinusDay?.remove(getStrDay(now));
      await makesNewNotification(taskMinusDay!, task.notiHours!)
          .then((value) => ids = value
      );
    }


    return await _firebaseCaller.updateData(
      path: FirestorePaths.taskById(user!, taskId: task.taskId),
      data: {
        'idNotification': ids
      },
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
    // }

  }

  Future<Either<Failure, bool>> updateIds({required TaskModel task}) async {
    List<int> ids = [];


    await makesNewNotification(task.days!, task.notiHours!)
        .then((value) => ids = value
    );

    return await _firebaseCaller.updateData(
      path: FirestorePaths.taskById(user!, taskId: task.taskId),
      data: {
        'idNotification': ids
      },
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }


  Future<Either<Failure, bool>> updateTask(Map<String, dynamic> datos,
      {required String taskId,}) async {
    return await _firebaseCaller.updateData(
      path: FirestorePaths.taskById(user!, taskId: taskId),
      data: datos,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );
  }


  cancelNotification(List<dynamic> listId) {
    listId.forEach((element) {
      AwesomeNotifications().cancel(element);
    });
  }

  Future<List<int>> makesNewNotification(List<dynamic> days,
      List<dynamic> hour) async {
    List<int> reIds = [];
    for (var element in days) {
      for (var element2 in hour) {
        await reCreateReminderNotification(
            getNumDay(element), element2)
            .then((value) => reIds.add(value)
        );
      }
    }
    return reIds;
  }

  Stream<List<TaskModel>> getNotiTaskStream() {
    cancelScheduledNotifications();
    var actualHour = DateTime.now();
    var actualDay = getTranslateDay();

    var formatter = DateFormat('hh:mm');
    String formattedDate = formatter.format(actualHour);

    return _firebaseCaller.collectionStream<TaskModel>(
      path: FirestorePaths.taskPath(user!),
      queryBuilder: (query) =>
          query
              .where("days", arrayContains: actualDay)
              .where("done", isEqualTo: "false"),
      builder: (snapshotData, snapshotId) {
        log('getNoti task repo 1');
        return TaskModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }
}*/

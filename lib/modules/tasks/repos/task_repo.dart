
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

  //tareas sin hacer
  Stream<List<TaskModel>> getTasksStream() {
    log('getTaskStream $user');
    var uidSupervised = _userRepo.userModel?.uidSupervised;
    return (uidSupervised == '')
        ? _firebaseCaller.collectionStream<TaskModel>(
      path: FirestorePaths.taskPath(user!),
      queryBuilder: (query) => query
          //.where('taskName', isNotEqualTo: 'tarea0')
          .where('done', isEqualTo: 'false'),
      builder: (snapshotData, snapshotId) {
         return TaskModel.fromMap(snapshotData!, snapshotId);
      },
    )
    :_firebaseCaller.collectionStream<TaskModel>(
      path: FirestorePaths.taskPath(uidSupervised!),
      queryBuilder: (query) => query
      //.where('taskName', isNotEqualTo: 'tarea0')
          .where('editable', isEqualTo: 'false'),
      builder: (snapshotData, snapshotId) {
        return TaskModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

  Stream<List<TaskModel>> getNotiTaskStream() {
    cancelScheduledNotifications();
    var actualHour = DateTime.now();
    var actualDay = getTranslateDay();

    var formatter = DateFormat('hh:mm');
    String formattedDate = formatter.format(actualHour);

    return  _firebaseCaller.collectionStream<TaskModel>(
      path: FirestorePaths.taskPath(user!),
      queryBuilder: (query) => query
          .where("days", arrayContains: actualDay)
          .where("done", isEqualTo: "false"),
      builder: (snapshotData, snapshotId) {
        log('getNoti task repo 1');
        return TaskModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }


  Stream<List<TaskModel>> getNotModTasksStream() {
    return _firebaseCaller.collectionStream<TaskModel>(
      path: FirestorePaths.taskPath(user!),
      queryBuilder: (query) => query
          .where('editable', isEqualTo: 'false'),
      builder: (snapshotData, snapshotId) {
        return TaskModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

  //tareas hechas
  Stream<List<TaskModel>> getTasksCompletedStream() {
    return _firebaseCaller.collectionStream<TaskModel>(
      path: FirestorePaths.taskPath(user!),
      queryBuilder: (query) => query
          .where('done', isEqualTo: 'true'),
      builder: (snapshotData, snapshotId) {
        return TaskModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

  Future<Either<Failure, bool>> checkTask({required TaskModel task}) async {

    return await _firebaseCaller.updateData(
      path: FirestorePaths.taskById(user!,taskId: task.taskId),
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

  Future<Either<Failure, bool>> cancelTodayNotifications({required TaskModel task}) async {
    var now = DateTime.now().weekday;
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
      if(taskMinusDay?.length == 1){
        //notificaciones de 0
        await makesNewNotification(task.days!, task.notiHours!)
            .then((value) => ids = value
        );
      } else{
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
      path: FirestorePaths.taskById(user!,taskId: task.taskId),
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


  Future<Either<Failure, bool>> updateTask(Map<String, dynamic> datos,{required String taskId,}) async {
    return await _firebaseCaller.updateData(
      path: FirestorePaths.taskById(user!,taskId: taskId),
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

  //tarea por nombre
  Future<Either<Failure?, TaskModel>> getTaskByName({
    required String taskId,
  }) async {
    return await _firebaseCaller.getData(
      path: FirestorePaths.taskById(user!,taskId: taskId),
      builder: (data, id) {
        if (data is! ServerFailure && data != null) {
          return Right(TaskModel.fromMap(data, id!));
        } else {
          return Left(data);
        }
      },
    );
  }

  // add task
  Future<Either<Failure, bool>> addSingleTask({
    required TaskModel task,
  }) async {
    var usuario = await getUsuario();
    var uidSup = usuario?.uidSupervised;
    //log('uid Sup $uidSup');

    //segun sea supervisor o no
    return (uidSup == '')
        ? await _firebaseCaller.setData(
      path: FirestorePaths.taskById(user!,taskId: task.taskId),
      data: task.toMap(),
        builder: (data) {
          if (data is! ServerFailure && data == true) {
            taskModel = task;
            return Right(data);
          } else {
            return Left(data);
          }
        }
    )
    :await _firebaseCaller.setData(
        path: FirestorePaths.taskById(uidSup!,taskId: task.taskId),
        data: task.toMap(),
        builder: (data) {
          if (data is! ServerFailure && data == true) {
            taskModel = task;

            return Right(data);
          } else {
            return Left(data);
          }
        }
    );
  }

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


  Future<Either<Failure, UserModel>> getUser() async {
    final result = await _userRepo.getUserData(user!);
    return result.fold(
      (failure) {
        return  Left(failure);
      },
      (userModel) {
        return Right(userModel!);
      },
    );
  }


  deleteSingleTask({
    required TaskModel taskModel
  }) async {
    cancelNotification(taskModel.idNotification!);
    return await _firebaseCaller.deleteData(
        path: FirestorePaths.taskById(user!,taskId: taskModel.taskId));
  }

  cancelNotification(List<dynamic> listId){
    listId.forEach((element) {
      AwesomeNotifications().cancel(element);
    });
  }

  Future<List<int>> makesNewNotification(List<dynamic> days, List<dynamic> hour) async {
   List<int> reIds = [];
    for (var element in days) {
      for (var element2 in hour) {
        await reCreateReminderNotification(
            getNumDay(element),element2)
            .then((value) => reIds.add(value)
        );
      }
    }
    return reIds;
  }

  Future<String> setTaskDoc(TaskModel taskData, String uid) async {
    log('setTaskDoc users/$uid/tasks');
    return await _firebaseCaller.addDataToCollection(
          path: 'users/$uid/tasks', ///tasks
          data: taskData.toMap()
    );
  }

  Future<Either<Failure, bool>> addDocToFirebase(TaskModel taskModel) async {
    log('uid user $user');
    // nos da el uid de la tarea
    taskModel.taskId = await setTaskDoc(taskModel,user!).then((value) => taskModel.taskId = value);
    log('id task ${taskModel.taskId}');

    final result = await addSingleTask(task: taskModel);
    return await result.fold(
          (failure) {
              return Left(failure);
            },
          (taskModel) async {
              if (taskModel == null) {
                return Right(taskModel);
              } else {
                return const Right(true);
              }
          },
    );
  }

/*
  Future<Either<Failure, bool>> resetTasks() async {
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate(); // TimeStamp to DateTime

    DatabaseReference ref = FirebaseDatabase.instance.ref("Totals");



    _firebaseCaller.collectionStream<TaskModel>(
      path: FirestorePaths.taskPath(user!),
      queryBuilder: (query) => query
      //.where('taskName', isNotEqualTo: 'tarea0')
          .where('done', isGreaterThanOrEqualTo: myTimeStamp.seconds-10),
      builder: (snapshotData, snapshotId) {
        return TaskModel.fromMap(snapshotData!, snapshotId);
      },
    );
    return await _firebaseCaller.updateData(
      path: FirestorePaths.getTaskCollection(user!),
      queryBuilder: (query) => query
          .where('editable', isEqualTo: 'false'),
      data: {
        'done': 'false',
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
*/

}
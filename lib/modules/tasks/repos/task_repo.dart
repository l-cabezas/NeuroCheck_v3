
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neurocheck/auth/viewmodels/auth_provider.dart';
import 'package:neurocheck/core/services/init_services/awesome_notification.dart';
import 'package:path/path.dart';

import '../../../auth/repos/user_repo.dart';
import '../../../core/errors/failures.dart';
import '../../../core/services/firebase_services/firebase_caller.dart';
import '../../../core/services/firebase_services/firestore_paths.dart';
import '../../../core/services/firebase_services/i_firebase_caller.dart';
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
    return _firebaseCaller.collectionStream<TaskModel>(
      path: FirestorePaths.taskPath(user!),
      queryBuilder: (query) => query
          //.where('taskName', isNotEqualTo: 'tarea0')
          .where('done', isEqualTo: 'false'),
      builder: (snapshotData, snapshotId) {
         return TaskModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

  Stream<List<TaskModel>> getNotiTaskStream() {
    var actualHour = DateTime.now();
    var actualDay = getTranslateDay();

    var formatter = DateFormat('hh:mm');
    String formattedDate = formatter.format(actualHour);

    log('getNoti task repo $formattedDate');

    return _firebaseCaller.collectionStream<TaskModel>(
      path: FirestorePaths.taskPath(user!),
      queryBuilder: (query) => query
          .where("days", arrayContains: actualDay)
          .where("oneTime", isEqualTo: 'false')
          .where("hours", arrayContains: formattedDate),
      builder: (snapshotData, snapshotId) {
        return TaskModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

  String getTranslateDay(){
    var actualDay = DateTime.now().weekday;
    String day = '';
    switch(actualDay){
      case 1:
        day = 'Lunes';
        break;
      case 2:
        day = 'Martes';
        break;
      case 3:
        day ='Miércoles';
        break;
      case 4:
        day = 'Jueves';
        break;
      case 5:
        day = 'Viernes';
        break;
      case 6:
        day = 'Sábado';
        break;
      case 7:
        day = 'Domingo';
        break;
    }
    return day;
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

  Future<Either<Failure, bool>> checkTask({required String taskId,}) async {
    return await _firebaseCaller.updateData(
      path: FirestorePaths.taskById(user!,taskId: taskId),
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
    required String id
  }) async {
    //log('TASK REPO ${user!}  ${task.taskName} ${task.days!} ${task.begin!}  ${task.end!}  ${task.editable!} ${task.done!}  ${task.numRepetition!}');

    return await _firebaseCaller.setData(
      path: FirestorePaths.taskById(user!,taskId: id),
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

  Future<String> setTaskDoc(TaskModel taskData) async {
    return await _firebaseCaller.addDataToCollection(
          path: 'users/$user!/tasks',
          data: taskData.toMap());
  }

  Future<Either<Failure, bool>> addDocToFirebase(TaskModel taskModel) async {
    final id = await setTaskDoc(taskModel);
    taskModel.taskId = id;
    final result = await addSingleTask(task: taskModel,id: id);
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

 /* Future<Either<Failure, bool>> resetTasks() async {

    _firebaseCaller.collectionStream<TaskModel>(
      path: FirestorePaths.taskPath(user!),
      queryBuilder: (query) => query
      //.where('taskName', isNotEqualTo: 'tarea0')
          .where('done', isEqualTo: 'false'),
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
  }*/

}
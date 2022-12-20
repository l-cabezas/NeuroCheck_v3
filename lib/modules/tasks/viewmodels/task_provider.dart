import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neurocheck/modules/tasks/viewmodels/tarea_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/repos/auth_repo.dart';
import '../../../auth/repos/user_repo.dart';
import '../../../core/errors/failures.dart';
import '../../../core/routing/navigation_service.dart';
import '../../../core/routing/route_paths.dart';
import '../../../core/services/firebase_services/firebase_caller.dart';
import '../../../core/services/firebase_services/firestore_paths.dart';
import '../../../core/services/firebase_services/i_firebase_caller.dart';
import '../../../core/services/init_services/firebase_messaging_service.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/viewmodels/main_core_provider.dart';
import '../models/task_model.dart';


final taskProvider =
StateNotifierProvider.autoDispose<TaskNotifier, TareaState>((ref) {
  return TaskNotifier(ref);
});

class TaskNotifier extends StateNotifier<TareaState> {
  TaskNotifier(this.ref) : super(const TareaState.available()) {
    _mainCoreProvider = ref.watch(mainCoreProvider);
    _authRepo = ref.watch(authRepoProvider);
    _userRepo = ref.watch(userRepoProvider);
    _firebaseCaller = ref.watch(firebaseCaller);
  }


  final Ref ref;
  late MainCoreProvider _mainCoreProvider;
  late AuthRepo _authRepo;
  late UserRepo _userRepo;
  late IFirebaseCaller _firebaseCaller;


  static bool supervisor = false;


  setSupervisor(bool set){
    supervisor = set;
  }

  Future<Either<Failure, bool>> checkTask({required TaskModel task}) async {
    state = const TareaState.loading();
    return await _firebaseCaller.updateData(
      path: FirestorePaths.taskById(GetStorage().read('uidUsuario')!,taskId: task.taskId),
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

  Future<Either<Failure, bool>> checkTaskBoss({required TaskModel task}) async {
    return await _firebaseCaller.updateData(
      path: FirestorePaths.taskBossById(GetStorage().read('uidUsuario')!,taskId: task.taskId),
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
  //-------------------
   addDocToFirebase(BuildContext context, TaskModel taskModel) async {
    // nos da el uid de la tarea
    state = const TareaState.loading();
    await _firebaseCaller.addDataToCollection(
        path: FirestorePaths.taskPath(GetStorage().read('uidUsuario')), ///tasks
        data: taskModel.toMap()
    );
    /*taskModel.taskId = await setTaskDoc(taskModel,GetStorage().read('uidUsuario')).then(
            (value) => taskModel.taskId = value
    );*/

    final result = (GetStorage().read('uidSup') != '')
        ?    await _firebaseCaller.setData(
        path: FirestorePaths.taskBossById(GetStorage().read('uidSup')!,
            taskId: taskModel.taskId),
        data: taskModel.toMap(),
        builder: (data) {
          if (data is! ServerFailure && data == true) {
            return Right(data);
          } else {
            return Left(data);
          }
        }
    )
        :  await _firebaseCaller.setData(
        path: FirestorePaths.taskById(GetStorage().read('uidUsuario')!,
            taskId: taskModel.taskId),
        data: taskModel.toMap(),
        builder: (data) {
          if (data is! ServerFailure && data == true) {
            return Right(data);
          } else {
            return Left(data);
          }
        }
    );

    //final result = await addSingleTask(task: taskModel);
    return await result.fold(
          (failure) {
            state =  TareaState.error(errorText: failure.message);
            AppDialogs.showErrorDialog(context, message: failure.message);
          },
          (taskModel) async {
            //state = TareaState.available();
            AppDialogs.addTaskOK(context,
                message: tr(context).addTaskDone);
      },
    );
  }



  //--------------------

   addDocToFirebaseBoss(BuildContext context,TaskModel taskModel) async {
    state = TareaState.loading();
    log('**** ADD DOC TO FB BOSS');
    taskModel.taskId = await _firebaseCaller.addDataToCollection(
        path: FirestorePaths.taskPathBoss(GetStorage().read('uidSup')), ///tasks
        data: taskModel.toMap()
    );
    final result = await _firebaseCaller.setData(
        path: FirestorePaths.taskBossById(GetStorage().read('uidSup'),taskId: taskModel.taskId),
        data: taskModel.toMap(),
        builder: (data) {
          if (data is! ServerFailure && data == true) {
            //taskModel = task;
            return Right(data);
          } else {
            return Left(data);
          }
        }
    );

    //final result = await addSingleTaskBoss(task: taskModel);
    return await result.fold(
          (failure) {
            state = TareaState.error(errorText: failure.message);
            AppDialogs.showErrorDialog(context, message: failure.message);
            //return Left(failure);
          },

          (taskModel) async {
            state = TareaState.available();
            log('**** ADD DOC TO FB BOSS 2');
            AppDialogs.addTaskOK(context,
                message: tr(context).addTaskDone);

      },
    );
  }

   updateTask(BuildContext context,Map<String, dynamic> datos,{required String taskId,}) async {
    log('**** UPDATE TASK ${GetStorage().read('uidUsuario')} ${taskId}');
     final result = await _firebaseCaller.updateData(
      path: FirestorePaths.taskById(GetStorage().read('uidUsuario')!,taskId: taskId),
      data: datos,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );

     return await result.fold(
           (failure) {
         state = TareaState.error(errorText: failure.message);
         AppDialogs.showErrorDialog(context, message: failure.message);
         //return Left(failure);
       },

           (taskModel) async {
         state = TareaState.available();
         AppDialogs.addTaskOK(context,
             message: tr(context).modTaskDone).then((value) => NavigationService.goBack(context,rootNavigator: true));
       },
     );
  }

   updateTaskBoss(BuildContext context,Map<String, dynamic> datos,{required String taskId,}) async {
     log('**** UPDATE TASK BOSS ${GetStorage().read('uidSup')} ${taskId}');
    final result = await _firebaseCaller.updateData(
      path: FirestorePaths.taskBossById(GetStorage().read('uidSup')!,taskId: taskId),
      data: datos,
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );

    return await result.fold(
          (failure) {
        state = TareaState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
        //return Left(failure);
      },

          (taskModel) async {
        state = TareaState.available();
        AppDialogs.addTaskOK(context,
            message: tr(context).modTaskDone).then((value) => NavigationService.goBack(context,rootNavigator: true));
      },
    );
  }

//-----------------------

  Future<void> deleteSingleTask({required TaskModel taskModel}) async {
    cancelNotification(taskModel.idNotification!);
    return await _firebaseCaller.deleteData(
        path: FirestorePaths.taskById(GetStorage().read('uidUsuario')!,taskId: taskModel.taskId));
  }
  cancelNotification(List<dynamic> listId){
    listId.forEach((element) { AwesomeNotifications().cancel(element);});
  }

  Future<void> deleteSingleTaskBoss({required TaskModel taskModel}) async {
    cancelNotification(taskModel.idNotification!);
    //borramos da
    return await _firebaseCaller.deleteData(
        path: FirestorePaths.taskBossById(GetStorage().read('uidSup')!,taskId: taskModel.taskId));
  }

  navigationToHomeScreen(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.home,
    );
  }

  subscribeUserToTopic() {
    FirebaseMessagingService.instance.subscribeToTopic(
      topic: 'general',
    );
  }


  navigationToCheckScreen(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.verifyEmail,
    );
  }

  navigationToLogin(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.authLogin,
    );
  }
}

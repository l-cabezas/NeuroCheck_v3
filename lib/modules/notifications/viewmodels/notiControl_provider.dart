import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/notifications/models/notiControl_model.dart';
import 'package:neurocheck/modules/notifications/viewmodels/notiControl_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/modules/tasks/models/task_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../auth/repos/auth_repo.dart';
import '../../../auth/repos/user_repo.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/services/firebase_services/firebase_caller.dart';
import '../../../core/services/firebase_services/firestore_paths.dart';
import '../../../core/services/firebase_services/i_firebase_caller.dart';
import '../../../core/viewmodels/main_core_provider.dart';
import '../repo/notiControl_repo.dart';
import 'notiControl_to_do.dart';

final notiControlProvider =
StateNotifierProvider.autoDispose<NotiControlNotifier, NotiControlState>((ref) {
  return NotiControlNotifier(ref);
});



class NotiControlNotifier extends StateNotifier<NotiControlState> {
  NotiControlNotifier(this.ref) : super(const NotiControlState.available()) {
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

  //añadimos
  void addNotiToFb(BuildContext context, NotiControlModel notiControlModel) async {
    // nos da el de la notification
    // 'users/$uid/notiControl'
    notiControlModel.notiId = await _firebaseCaller.addDataToCollection(
        path: FirestorePaths.notificationPass(GetStorage().read('uidUsuario')), ///tasks
        data: notiControlModel.toMap()
    );


    await _firebaseCaller.updateData(
        path: FirestorePaths.notificationPassById(GetStorage().read('uidUsuario'),notiId:notiControlModel.notiId),
        data: notiControlModel.toMap(),
        builder: (data) {
          if (data is! ServerFailure && data == true) {
            return Right(data);
          } else {
            return Left(data);
          }
        }
    );

    await _firebaseCaller.updateData(
        path: FirestorePaths.taskById(GetStorage().read('uidUsuario'),taskId:notiControlModel.taskId),
        data: {
          'refNoti' : notiControlModel.notiId
        },
        builder: (data) {
          if (data is! ServerFailure && data == true) {
            //control notificaciones
            return Right(data);
          } else {
            return Left(data);
          }
        }
    );
  }

  void addNotiToFbBoss(BuildContext context, NotiControlModel notiControlModel) async {
    // nos da el de la notification

    //obtenemos id y add noti
    notiControlModel.notiId = await _firebaseCaller.addDataToCollection(
        path: FirestorePaths.notificationPass(GetStorage().read('uidSup')), ///tasks
        data: notiControlModel.toMap()
    );

    //add id noti
    await _firebaseCaller.setData(
        path: FirestorePaths.notificationPassById(GetStorage().read('uidSup')
            ,notiId:notiControlModel.notiId),
        data: notiControlModel.toMap(),
        builder: (data) {
          if (data is! ServerFailure && data == true) {
            //control notificaciones
            return Right(data);
          } else {
            return Left(data);
          }
        }
    );

    //referencia desde la task a la noti
    await _firebaseCaller.updateData(
        path: FirestorePaths.taskBossById(GetStorage().read('uidSup'),taskId:notiControlModel.taskId),
        data: {
          'refNoti' : notiControlModel.idNotification
        },
        builder: (data) {
          if (data is! ServerFailure && data == true) {
            //control notificaciones
            return Right(data);
          } else {
            return Left(data);
          }
        }
    );
  }

  //borramos
  Future<void> deleteNotiControl({required NotiControlModel notiControlModel}) async {
    return await _firebaseCaller.deleteData(
        path: FirestorePaths.notificationPassById(GetStorage().read('uidUsuario')!,
            notiId: notiControlModel.notiId));
  }

  Future<void> deleteNotiControlBoss({required NotiControlModel notiControlModel}) async {
    return await _firebaseCaller.deleteData(
        path: FirestorePaths.notificationPassById(GetStorage().read('uidSup')!,
            notiId: notiControlModel.notiId));
  }

  Future<void> deleteNotiControlWT({required TaskModel taskModel}) async {
    return await _firebaseCaller.deleteData(
        path: FirestorePaths.notificationPassByTaskId(GetStorage().read('uidUsuario')!,
            notiId: taskModel.cancelNoti!));
  }


  //checkeamos
  void checkDelete({required TaskModel taskModel}) async {

    var lista_noti = await _firebaseCaller.collectionStream<NotiControlModel>(
      //uid de usuario
      path: FirestorePaths.notificationPass(GetStorage().read('uidUsuario')),
      queryBuilder: (query) => query
          .where("taskId", isEqualTo: taskModel.taskId),
      builder: (snapshotData, snapshotId) {
        return NotiControlModel.fromMap(snapshotData!, snapshotId);
      },
    );

    lista_noti.forEach((element) {
      element.forEach((noti) async {
        await _firebaseCaller.updateData(
          path: FirestorePaths.notificationPassById(GetStorage().read('uidUsuario'),notiId: noti.notiId),
          data: {
            'cancel': 'true',
          },
          builder: (data) {  },

        );
      });
    });

    /*return await _firebaseCaller.updateData(
      path: FirestorePaths.notificationPassByTaskId(GetStorage().read('uidUsuario')!,taskId:
      taskModel.taskId),
      data: {
        'cancel': 'true',
      },
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );*/
  }



  Future<void> updateIds({required TaskModel taskModel}) async {
    String? idNoti = taskModel.cancelNoti;
    await _firebaseCaller.updateData(
        path: FirestorePaths.notificationPassById(GetStorage().read('uidUsuario'), notiId:idNoti!),
        data: {
          'idNotification' : taskModel.idNotification
        },
        builder: (data) {
          if (data is! ServerFailure && data == true) {
            //control notificaciones
            return Right(data);
          } else {
            return Left(data);
          }
        }
    );

    /*var lista_noti = ref.watch(notiControlRepoProvider).getNotiStream();
    lista_noti.forEach((element) {
      element.forEach((element) async {
        log('**** LOOP ${element.notiId}');
        await _firebaseCaller.updateData(
          path: FirestorePaths.notificationPassById(GetStorage().read('uidUsuario'),notiId: element.notiId),
          data: {
            'idNotification': taskModel.idNotification,
          },
          builder: (data) {
            if (data is! ServerFailure && data == true) {
              return Right(data);
            } else {
              return Left(data);
            }
          },
        );
      });
    });*/


    /*await _firebaseCaller.getCollectionData(
      //uid de usuario
      path: FirestorePaths.notificationPass(GetStorage().read('uidUsuario')),
      queryBuilder: (query) => query
          .where("taskId", isEqualTo: taskModel.taskId),
      builder: (List<QueryDocumentSnapshot<Map<String, dynamic>>>? data) {
        data.forEach((element) {
          NotiControlModel.fromMap(element);
        });

      },
    );*/

    /*lista_noti.forEach((element) {
      log('**** NOTICONTROL ${element.length}');
      element.forEach((noti) async {
        log('**** UPDATE IDS NOTI');
        *//*await _firebaseCaller.updateData(
          path: FirestorePaths.notificationPassById(GetStorage().read('uidUsuario'),notiId: noti.notiId),
          data: {
            'idNotification': taskModel.idNotification,
          },
          builder: (data) {
            if (data is! ServerFailure && data == true) {
              return Right(data);
            } else {
              return Left(data);
            }
          },
        );*//*
      });
    });*/
    /*return await _firebaseCaller.updateData(
      path: FirestorePaths.notificationPass(GetStorage().read('uidUsuario')),

      data: {
        'idNotification': taskModel.idNotification,
      },
      builder: (data) {
        if (data is! ServerFailure && data == true) {
          return Right(data);
        } else {
          return Left(data);
        }
      },
    );*/
  }


}

import 'package:get_storage/get_storage.dart';
import 'package:neurocheck/features/home/domain/use_cases/update_task_status_uc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/data/error/app_exception.dart';
import '../../../../core/data/network/i_firebase_firestore_caller.dart';
import '../../../../core/data/network/main_api/api_callers/main_api_firestore_caller.dart';
import '../models/task_model.dart';

part 'home_remote_data_source.g.dart';

abstract class IHomeRemoteDataSource {
  /// Calls the api endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Stream<List<TaskModel>> getTasksStream();

  Stream<List<TaskModel>> getTasksStreamBoss();

  Future<void> updateTaskStatus(UpdateTaskStatusParams params);

  Future<TaskModel> getTask(String taskId);

  //Future<void> updateDeliveryGeoPoint(UpdateDeliveryGeoPointParams params);
}

@Riverpod(keepAlive: true)
IHomeRemoteDataSource homeRemoteDataSource(HomeRemoteDataSourceRef ref) {
  return HomeRemoteDataSource(
    ref,
    firebaseFirestoreCaller: ref.watch(mainApiFirestoreCallerProvider),
  );
}

class HomeRemoteDataSource implements IHomeRemoteDataSource {
  HomeRemoteDataSource(
    this.ref, {
    required this.firebaseFirestoreCaller,
  });

  final HomeRemoteDataSourceRef ref;
  final IFirebaseFirestoreCaller firebaseFirestoreCaller;

  static  String tasksCollectionPath = 'users/${GetStorage().read('uidUsuario')}/tasks';

  static  String tasksBossCollectionPath =  'users/${GetStorage().read('uidSup')}/tasksBoss';

  static String taskDocPath(String taskId) =>
      '/${tasksCollectionPath}/${taskId}';

  static String taskBossDocPath(String taskId) =>
      '${tasksBossCollectionPath}/$taskId';



  @override
  Stream<List<TaskModel>> getTasksStream() {
    final snapshots = firebaseFirestoreCaller.collectionStream(
      path: tasksCollectionPath,
      queryBuilder: (query) => query
          .where('done', isEqualTo: 'false')
          .where('cancel',isEqualTo: 'false')
          .where('isNotificationSet',isEqualTo: 'false')
    );
    return snapshots
        .map((snapshot) => TaskModel.parseListOfDocument(snapshot.docs));
  }

  @override
  Stream<List<TaskModel>> getTasksStreamBoss() {
    final snapshots = firebaseFirestoreCaller.collectionStream(
        path: tasksBossCollectionPath,
        queryBuilder: (query) => query
            .where('done', isEqualTo: 'false')
            .where('cancel',isEqualTo: 'false')
            .where('isNotificationSet',isEqualTo: 'false')
    );
    return snapshots
        .map((snapshot) => TaskModel.parseListOfDocument(snapshot.docs));
  }

  @override
  Future<void> updateTaskStatus(UpdateTaskStatusParams params) async {
    var sup = GetStorage().read('uidSup');
    if(sup != ''){
      await firebaseFirestoreCaller.updateData(
        path: taskBossDocPath(params.taskId),
        data: params.toMap(),
      );
    }else{
      await firebaseFirestoreCaller.updateData(
        path: taskDocPath(params.taskId),
        data: params.toMap(),
      );
    }

  }

  @override
  Future<TaskModel> getTask(String taskId) async {
    var sup = GetStorage().read('uidSup');
    if(sup != ''){
      final response =
      await firebaseFirestoreCaller.getData(path: taskBossDocPath(taskId));
      if (response.data() != null) {
        return TaskModel.fromMap(
          response.data() as Map<String, dynamic>,
          response.id,
        );
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'Task not found.',
        );
      }
    }else{
      final response =
      await firebaseFirestoreCaller.getData(path: taskDocPath(taskId));
      if (response.data() != null) {
        return TaskModel.fromMap(
          response.data() as Map<String, dynamic>,
          response.id,
        );
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'Task not found.',
        );
      }
    }

  }

}

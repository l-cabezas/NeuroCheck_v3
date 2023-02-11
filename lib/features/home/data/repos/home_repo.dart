import 'dart:async';

import 'package:neurocheck/features/home/data/models/task_model.dart';
import 'package:neurocheck/features/home/domain/use_cases/update_task_status_uc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repos/i_home_repo.dart';
import '../data_sources/home_remote_data_source.dart';

part 'home_repo.g.dart';

@Riverpod(keepAlive: true)
IHomeRepo homeRepo(HomeRepoRef ref) {
  return HomeRepo(
    remoteDataSource: ref.watch(homeRemoteDataSourceProvider),
  );
}

class HomeRepo implements IHomeRepo {
  HomeRepo({
    required this.remoteDataSource,
  });

  final IHomeRemoteDataSource remoteDataSource;



  @override
  Stream<List<TaskModel>> getUpcomingTaskStream() {
    return remoteDataSource.getTasksStream();
  }

  @override
  Stream<List<TaskModel>> getUpcomingTaskStreamBoss() {
    return remoteDataSource.getTasksStreamBoss();
  }

  @override
  Future<void> updateTask(UpdateTaskStatusParams params) async {
    return await remoteDataSource.updateTaskStatus(params);
  }

  @override
  Future<TaskModel> getTask(String taskId) async {
    final task = await remoteDataSource.getTask(taskId);
    return task;
  }


}

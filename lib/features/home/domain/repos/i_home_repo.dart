import 'dart:async';

import 'package:neurocheck/features/home/data/models/task_model.dart';

import '../use_cases/update_task_status_uc.dart';

abstract class IHomeRepo {
  Stream<List<TaskModel>> getUpcomingTaskStream();

  Stream<List<TaskModel>> getUpcomingTaskStreamBoss();

  Future<TaskModel> getTask(String taskId);

  Future<void> updateTask(UpdateTaskStatusParams params);

 // Future<void> updateDeliveryGeoPoint(UpdateDeliveryGeoPointParams params);
}

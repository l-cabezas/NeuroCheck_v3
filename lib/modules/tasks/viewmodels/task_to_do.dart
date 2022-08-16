import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/tasks/repos/task_repo.dart';

import '../models/task_model.dart';

final taskToDoStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  return ref.watch(tasksRepoProvider).getTasksStream();
});

final taskToDoCompleteStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  return ref.watch(tasksRepoProvider).getTasksCompletedStream();
});
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/auth/repos/user_repo.dart';
import 'package:neurocheck/modules/tasks/repos/task_repo.dart';
import 'package:rxdart/rxdart.dart';

import '../../../auth/models/user_model.dart';
import '../models/task_model.dart';

final taskToDoStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  return ref.watch(tasksRepoProvider).getTasksStream();
});

final taskToDoStreamProviderBoss = StreamProvider<List<TaskModel>>((ref) {
  return ref.watch(tasksRepoProvider).getTasksBossStream();
});

final taskMultipleToDoStreamProvider = StreamProvider<List<List<TaskModel>>>((ref) {
  return CombineLatestStream.list([
  ref.watch(tasksRepoProvider).getTasksStream(),
    ref.watch(tasksRepoProvider).getTasksBossStream()]);
});

final taskToDoCompleteStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  return ref.watch(tasksRepoProvider).getTasksCompletedStream();
});
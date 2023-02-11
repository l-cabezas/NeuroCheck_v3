import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/tasks/repos/task_repo.dart';
import 'package:rxdart/rxdart.dart';

import '../../../features/home/data/models/task_model.dart';

final taskMultipleToDoStreamProviderNOTDONE = StreamProvider<List<List<TaskModel>>>((ref) {
  return CombineLatestStream.list([
    ref.watch(tasksRepoProvider).getTasksStream(),
    ref.watch(tasksRepoProvider).getTasksBossS()
  ]);
});

final taskMultipleAll = StreamProvider<List<List<TaskModel>>>((ref) {
  return CombineLatestStream.list([
    ref.watch(tasksRepoProvider).getTasksStream(),
    ref.watch(tasksRepoProvider).getTasksBossS(),
    ref.watch(tasksRepoProvider).getTasksDoneStream(),
    ref.watch(tasksRepoProvider).getTasksDoneStreamBossS()
  ]);
});

final taskMultipleToDoStreamProviderDONE = StreamProvider<List<List<TaskModel>>>((ref) {
  return CombineLatestStream.list([
    ref.watch(tasksRepoProvider).getTasksDoneStream(),
    ref.watch(tasksRepoProvider).getTasksDoneStreamBossS()
  ]);
});

final taskMultipleToDoStreamProviderBoss = StreamProvider<List<List<TaskModel>>>((ref) {
  return CombineLatestStream.list([
    ref.watch(tasksRepoProvider).getTasksBossStream(),
    ]);
});



final taskMultipleToDoCompleteStreamProviderBoss = StreamProvider<List<List<TaskModel>>>((ref) {
  return CombineLatestStream.list([
    ref.watch(tasksRepoProvider).getTasksDoneStreamBoss(),
  ]);
});


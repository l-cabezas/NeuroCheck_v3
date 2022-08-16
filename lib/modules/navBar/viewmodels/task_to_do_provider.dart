import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/tasks/models/task_model.dart';
import 'package:neurocheck/modules/tasks/repos/task_repo.dart';

final taskToDoStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  return ref.watch(tasksRepoProvider).getTasksStream();
});

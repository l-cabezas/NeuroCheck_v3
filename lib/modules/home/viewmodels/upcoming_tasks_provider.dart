
//upcomingOrdersStreamProvider
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/home/data/models/task_model.dart';
import '../../tasks/repos/task_repo.dart';

final upcomingTasksStreamProvider = StreamProvider<List<TaskModel>>((ref) {
  return ref.watch(tasksRepoProvider).getNotiTaskStream();
});

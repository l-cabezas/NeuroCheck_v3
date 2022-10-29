
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../tasks/repos/task_repo.dart';

final taskToNotifyStreamProvider = StreamProvider((ref) =>
    ref.watch(tasksRepoProvider).getNotiTaskStream());
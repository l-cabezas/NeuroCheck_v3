import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/modules/tasks/models/task_model.dart';
import 'package:neurocheck/modules/tasks/repos/task_repo.dart';

import '../../../core/routing/navigation_service.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/utils/flush_bar_component.dart';
import '../components/forms/days/multi_choice_provider.dart';
import '../components/forms/name_task/name_task_provider.dart';
import '../components/forms/range/time_range_picker_provider.dart';
import '../components/forms/repetitions/repe_noti_provider.dart';

final taskProvider =
StateNotifierProvider.autoDispose<TaskNotifier, TaskState>((ref) {
  return TaskNotifier(ref);
});

class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier(this.ref) : super( TaskState.success) {
    _taskRepo = ref.watch(tasksRepoProvider);
  }

  final Ref ref;
  late TasksRepo _taskRepo;

  addSingleTask(
      BuildContext context, {
        required TaskModel task,
      }) async {
    NavigationService.removeAllFocus(context);
     await _taskRepo.addDocToFirebase(task).then((value) {
       FlushBarNotification.showError(context: context, message: tr(context).addTaskDone);
         ref.read(nameTaskProvider.notifier).clean();
         ref.refresh(nameTaskProvider);

         ref.read(selectDaysMultiChoice.notifier).clean();
         ref.refresh(selectDaysMultiChoice);

         ref.read(timeRangeButtonProvider.notifier).clean();
         ref.refresh(timeRangeButtonProvider);
         
         ref.read(timeRepetitionProvider.notifier).clean();
         ref.refresh(timeRepetitionProvider);
         }
     );
  }
}

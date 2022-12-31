
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/modules/home/viewmodels/task_dialogs_viewmodels.dart';

import '../../../core/presentation/routing/navigation_service.dart';
import '../../../core/utils/dialogs.dart';
import '../../tasks/repos/task_repo.dart';


final notificationOViewModel = Provider<NotificationOViewModel>(
        (ref) => NotificationOViewModel(ref));

class NotificationOViewModel {
  NotificationOViewModel(this.ref);

  Ref ref;

  navigateToNotificationOrder(String notificationId) async {
    final _result = await ref
        .watch(tasksRepoProvider)
        .getTaskByName(taskId: notificationId);
        //.getOrderById(orderId: notificationOrderId);
    await _result.fold(
          (failure) {
                AppDialogs.showErrorDialog(
                  NavigationService.context,
                  message: failure?.message,
                );
              },
          (task) async {
        //Few delay to ensure dispose of old map viewmodels.
        await Future.delayed(const Duration(seconds: 1));
        ref.watch(taskDialogsViewModel).setSelectedTaskProvidersAndGoToHome(
          NavigationService.context,
          task,
        );
      },
    );
  }
}

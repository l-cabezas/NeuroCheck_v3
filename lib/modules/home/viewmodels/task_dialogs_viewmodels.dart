
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/tasks/repos/task_repo.dart';

import '../../../core/routing/navigation_service.dart';
import '../../../core/routing/route_paths.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../navBar/components/dialogs/cancel_order_dialog.dart';
import '../../tasks/models/task_model.dart';
import '../components/dialogs/task_details_dialog.dart';
import '../models/noti_model.dart';
import 'home_state_providers.dart';
import 'noti_providers.dart';
import 'package:collection/collection.dart';

final taskDialogsViewModel =
Provider<TaskDialogsViewModel>((ref) => TaskDialogsViewModel(ref));

class TaskDialogsViewModel {
  TaskDialogsViewModel(this.ref) {
    _tasksRepo = ref.watch(tasksRepoProvider);
    _notificationTaskProvider = ref.watch(notificationTaskProvider.notifier);
  }

  Ref ref;
  late TasksRepo _tasksRepo;
  late NotiTaskNotifier _notificationTaskProvider;

  showOrderDetailsDialog(
      BuildContext context, {
        required TaskModel taskModel,
      }) {
    DialogWidget.showCustomDialog(
      context: context,
      child: TaskDetailsDialog(
        taskModel: taskModel,
      ),
    );
  }

  showDeliverOrderDialog(
      BuildContext context, {
        required NotiModel notiModel,
      }) async {
    /*bool _confirm = await _confirmChoiceDialog(
      context,
      'tr(context).doYouWantToDeliverTheOrder',
    );*/
    /*if (_confirm) {
      final _result =
      await _tasksRepo.deliverUserOrder(taskId: notiModel.taskId!);
      _result.fold(
            (failure) {
          AppDialogs.showErrorDialog(
            context,
            message: failure.message,
          );
        },
            (isSet) {
          if (isSet) {
            setSelectedOrderProvidersAndGoToMap(context, notiModel);
            _notificationTaskProvider.addTaskToDo(
                taskId: notiModel.taskId!);
          }
        },
      );
    }*/
  }


//seleccionada la notificacion nos lleva a la app
  setSelectedTaskProvidersAndGoToHome(
      BuildContext context, TaskModel taskModel) {
    ref.watch(selectedNotiProvider.notifier).state = taskModel;

    /*final _deliveringOrder = ref
        .read(notificationTaskProvider)
        .firstWhereOrNull((task) => task.taskId == taskModel.taskId);*/
   /* ref.watch(selectedPlaceGeoPointProvider.notifier).state =
        _deliveringOrder?.orderGeoPoint ?? orderModel.addressModel?.geoPoint;*/

    NavigationService.push(
      context,
      isNamed: true,
      rootNavigator: true,
      page: RoutePaths.homeBase,
    );
  }
}

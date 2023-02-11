import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocheck/modules/home/viewmodels/noti_providers.dart';

import '../../../core/widgets/dialog_widget.dart';
import '../../../features/home/data/models/task_model.dart';
import '../../tasks/repos/task_repo.dart';
import '../components/dialogs/cancel_task_dialog.dart';
import '../components/dialogs/confirm_choice_dialog.dart';
import '../components/dialogs/task_details_dialog.dart';
import '../models/noti_model.dart';

final orderDialogsViewModel =
    Provider<OrderDialogsViewModel>((ref) => OrderDialogsViewModel(ref));

class OrderDialogsViewModel {
  OrderDialogsViewModel(this.ref) {
    _tasksRepo = ref.watch(tasksRepoProvider);
    _notiTaskProvider = ref.watch(notificationTaskProvider.notifier);
  }

  Ref ref;
  late TasksRepo _tasksRepo;
  late NotiTaskNotifier _notiTaskProvider;

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

  showCancelOrderDialog(
    BuildContext context, {
    required TaskModel taskModel,
  }) async {
    //if (_confirmDeliveryId(context, taskModel.taskId)) {
      await DialogWidget.showCustomDialog(
        context: context,
        child: CancelTaskDialog(
          taskModel: taskModel,
        ),
      ).then((value) async {
        /*if (value != null && value[0] == true) {
          final _result = await _tasksRepo.cancelUserOrder(
            orderId: orderModel.orderId!,
            employeeCancelNote: value[1],
          );
          _result.fold(
            (failure) {
              AppDialogs.showErrorDialog(
                context,
                message: failure.message,
              );
            },
            (isSet) {},
          );
        }*/
      });
    //}
  }

  showDeliverOrderDialog(
    BuildContext context, {
    required NotiModel orderModel,
  }) async {
    bool _confirm = await _confirmChoiceDialog(
      context,
      'tr(context).doYouWantToDeliverTheOrder',
    );
    /*if (_confirm) {
      final _result =
          await _tasksRepo.deliverUserOrder(orderId: orderModel.orderId!);
      _result.fold(
        (failure) {
          AppDialogs.showErrorDialog(
            context,
            message: failure.message,
          );
        },
        (isSet) {
          if (isSet) {
            setSelectedOrderProvidersAndGoToMap(context, orderModel);
            _notiTaskProvider.addTaskToDo(
                orderId: orderModel.orderId!);
          }
        },
      );
    }*/
  }

  Future<bool> showConfirmOrderDialog(
    BuildContext context, {
    required NotiModel orderModel,
  }) async {
    bool _orderConfirmed = false;
    /*if (_confirmDeliveryId(context, orderModel.deliveryId)) {
      bool _confirm = await _confirmChoiceDialog(
        context,
        tr(context).doYouWantToConfirmTheOrder,
      );
      if (_confirm) {
        final _result =
            await _tasksRepo.confirmUserOrder(orderId: orderModel.orderId!);
        _result.fold(
          (failure) {
            AppDialogs.showErrorDialog(
              context,
              message: failure.message,
            );
          },
          (isSet) {
            if (isSet) {
              _notiTaskProvider.deleteOrderFromDeliveringOrders(
                orderId: orderModel.orderId!,
              );
              _orderConfirmed = true;
            }
          },
        );
      }
    }*/
    return _orderConfirmed;
  }


  Future<bool> _confirmChoiceDialog(
    BuildContext context,
    String message,
  ) async {
    bool _isConfirm = false;
    _isConfirm = await DialogWidget.showCustomDialog(
      context: context,
      child: ConfirmChoiceDialog(
        message: message,
      ),
    ).then((value) {
      if (value == null) return false;
      return value[0];
    });
    return _isConfirm;
  }

/*  setSelectedOrderProvidersAndGoToMap(
      BuildContext context, NotiModel orderModel) {
    ref.watch(selectedNotiProvider.notifier).state = orderModel;

    final _deliveringOrder = ref
        .read(notificationTaskProvider) //deliveringOrdersProvider
        .firstWhereOrNull((order) => order.orderId == orderModel.orderId);
    ref.watch(selectedPlaceGeoPointProvider.notifier).state =
        _deliveringOrder?.orderGeoPoint ?? orderModel.addressModel?.geoPoint;

    NavigationService.push(
      context,
      isNamed: true,
      rootNavigator: true,
      page: RoutePaths.map,
    );
  }*/
}

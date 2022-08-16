import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/routing/navigation_service.dart';
import '../../../core/routing/route_paths.dart';
import '../../../core/services/init_services/local_notification_service.dart';
import '../../../core/services/localization_service.dart';
import '../../notifications/models/notification_model.dart';
import '../models/noti_model.dart';
import 'package:collection/collection.dart';

final notificationTaskProvider =
StateNotifierProvider<NotiTaskNotifier, List<NotiModel>>(
        (ref) => NotiTaskNotifier(ref));

class NotiTaskNotifier
    extends StateNotifier<List<NotiModel>> {
  NotiTaskNotifier(this.ref) : super([]);

  final Ref ref;

  addTaskToDo({required String taskId}) {
    final isExist = state.firstWhereOrNull(
            (task) => task.taskId== taskId
    );
    if (isExist == null) {
      state.add(NotiModel(taskId: taskId));
    }
  }


  deleteOrderFromDeliveringOrders({required String taskId}) {
    state.removeWhere((task) => task.taskId == taskId);
  }


  //Send local notification when any order arrive.
/*
  checkArrivedDeliveringOrders(Position location) {
    for (final order in state) {
      if (order.orderGeoPoint != null && order.didShowNotification == false) {
        final _distance = MapService.instance.getDistanceBetweenTwoCoordinates(
          firstLocation: LatLng(
            order.orderGeoPoint!.latitude,
            order.orderGeoPoint!.longitude,
          ),
          secondLocation: LatLng(
            location.latitude,
            location.longitude,
          ),
        );
        if (_distance < locationArriveDistance) {
          showOrderArrivedNotification(order.orderId);
          order.didShowNotification = true;
        }
      }
    }
  }
*/

  showOrderArrivedNotification(String taskId) {
    final _notificationModel = NotificationModel(
      route: RoutePaths.homeBase,
      data: {'taskId': taskId},
    );
    LocalNotificationService.instance.showInstantNotification(
      title: 'tr(NavigationService.context).arrivedLocation',
      body: 'tr(NavigationService.context).youAreCloseToLocationArea',
      payload: _notificationModel.toJsonString(),
    );
  }
}
